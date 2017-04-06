# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  # alert "aaaaa"
  # $('.chosen-select').chosen();
  $('[data-toggle="tooltip"]').tooltip()
  intro = $('.cd-intro-block')
  projectsContainer = $('.cd-projects-wrapper')
  projectsSlider = projectsContainer.children('.cd-slider')
  singleProjectContent = $('.cd-project-content')
  sliderNav = $('.cd-slider-navigation')
  resizing = false
  #if on desktop - set a width for the projectsSlider element

  showProjectPreview = (project) ->
    if project.length > 0
      setTimeout (->
        project.addClass 'slides-in'
        showProjectPreview project.next()
        return
      ), 50
    return

  checkMQ = ->
    #check if mobile or desktop device
    window.getComputedStyle(document.querySelector('.cd-projects-wrapper'), '::before').getPropertyValue('content').replace(/'/g, '').replace /"/g, ''

  setSliderContainer = ->
    mq = checkMQ()
    if mq == 'desktop'
      slides = projectsSlider.children('li')
      slideWidth = slides.eq(0).width()
      marginLeft = Number(projectsSlider.children('li').eq(1).css('margin-left').replace('px', ''))
      sliderWidth = (slideWidth + marginLeft) * (slides.length + 1) + 'px'
      slideCurrentIndex = projectsSlider.children('li.current').index()
      projectsSlider.css 'width', sliderWidth
      slideCurrentIndex != 0 and setTranslateValue(projectsSlider, slideCurrentIndex * (slideWidth + marginLeft) + 'px')
    else
      projectsSlider.css 'width', ''
      setTranslateValue projectsSlider, 0
    resizing = false
    return

  nextSides = (slider) ->
    actual = slider.children('.current')
    index = actual.index()
    following = actual.nextAll('li').length
    width = actual.width()
    marginLeft = Number(slider.children('li').eq(1).css('margin-left').replace('px', ''))
    index = if following > 4 then index + 3 else index + following - 2
    #calculate the translate value of the slider container
    translate = index * (width + marginLeft) + 'px'
    slider.addClass 'next'
    setTranslateValue slider, translate
    slider.one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
      updateSlider 'next', actual, slider, following
      return
    if $('.no-csstransitions').length > 0
      updateSlider 'next', actual, slider, following
    return

  prevSides = (slider) ->
    actual = slider.children('.previous')
    index = actual.index()
    width = actual.width()
    marginLeft = Number(slider.children('li').eq(1).css('margin-left').replace('px', ''))
    translate = index * (width + marginLeft) + 'px'
    slider.addClass 'prev'
    setTranslateValue slider, translate
    slider.one 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
      updateSlider 'prev', actual, slider
      return
    if $('.no-csstransitions').length > 0
      updateSlider 'prev', actual, slider
    return

  updateSlider = (direction, actual, slider, numerFollowing) ->
    if direction == 'next'
      slider.removeClass('next').find('.previous').removeClass 'previous'
      actual.removeClass 'current'
      if numerFollowing > 4
        actual.addClass('previous').next('li').next('li').next('li').addClass 'current'
      else if numerFollowing == 4
        actual.next('li').next('li').addClass('current').prev('li').prev('li').addClass 'previous'
      else
        actual.next('li').addClass('current').end().addClass 'previous'
    else
      slider.removeClass('prev').find('.current').removeClass 'current'
      actual.removeClass('previous').addClass 'current'
      if actual.prevAll('li').length > 2
        actual.prev('li').prev('li').prev('li').addClass 'previous'
      else
        !slider.children('li').eq(0).hasClass('current') and slider.children('li').eq(0).addClass('previous')
    updateNavigation()
    return

  updateNavigation = ->
    #update visibility of next/prev buttons according to the visible slides
    current = projectsContainer.find('li.current')
    if current.is(':first-child') then sliderNav.find('.prev').addClass('inactive') else sliderNav.find('.prev').removeClass('inactive')
    if current.nextAll('li').length < 3 then sliderNav.find('.next').addClass('inactive') else sliderNav.find('.next').removeClass('inactive')
    return

  setTranslateValue = (item, translate) ->
    item.css
      '-moz-transform': 'translateX(-' + translate + ')'
      '-webkit-transform': 'translateX(-' + translate + ')'
      '-ms-transform': 'translateX(-' + translate + ')'
      '-o-transform': 'translateX(-' + translate + ')'
      'transform': 'translateX(-' + translate + ')'
    return

  setSliderContainer()
  $(window).on 'resize', ->
    #on resize - update projectsSlider width and translate value
    if !resizing
      if !window.requestAnimationFrame then setSliderContainer() else window.requestAnimationFrame(setSliderContainer)
      resizing = true
    return
  #show the projects slider if user clicks the show-projects button
  intro.on 'click', 'a[data-action="show-projects"]', (event) ->
    event.preventDefault()
    intro.addClass 'projects-visible'
    projectsContainer.addClass 'projects-visible'
    #animate single project - entrance animation
    setTimeout (->
      showProjectPreview projectsSlider.children('li').eq(0)
      return
    ), 200
    return
  intro.on 'click', (event) ->
    #projects slider is visible - hide slider and show the intro panel
    if intro.hasClass('projects-visible') and !$(event.target).is('a[data-action="show-projects"]')
      intro.removeClass 'projects-visible'
      projectsContainer.removeClass 'projects-visible'
    return
  #select a single project - open project-content panel
  projectsContainer.on 'click', '.cd-slider a', (event) ->
    clicked_element = $(this).attr "id"
    id = clicked_element.replace('post_thumb_', '')
    mq = checkMQ()
    event.preventDefault()
    if $(this).parent('li').next('li').is('.current') and mq == 'desktop'
      prevSides projectsSlider
    else if $(this).parent('li').prev('li').prev('li').prev('li').is('.current') and mq == 'desktop'
      nextSides projectsSlider
    else
      # ajax call for single project detail
      $.ajax
        url: "/posts/" + id,
        success: (html) ->
          singleProjectContent.addClass 'is-visible'
          return
        error: (html) ->
          return
    return
  #close single project content
  singleProjectContent.on 'click', '.close', (event) ->
    event.preventDefault()
    singleProjectContent.removeClass 'is-visible'
    return
  #go to next/pre slide - clicking on the next/prev arrow
  sliderNav.on 'click', '.next', ->
    nextSides projectsSlider
    return
  sliderNav.on 'click', '.prev', ->
    prevSides projectsSlider
    return
  #go to next/pre slide - keyboard navigation
  $(document).keyup (event) ->
    mq = checkMQ()
    if event.which == '37' and intro.hasClass('projects-visible') and !sliderNav.find('.prev').hasClass('inactive') and mq == 'desktop'
      prevSides projectsSlider
    else if event.which == '39' and intro.hasClass('projects-visible') and !sliderNav.find('.next').hasClass('inactive') and mq == 'desktop'
      nextSides projectsSlider
    else if event.which == '27' and singleProjectContent.hasClass('is-visible')
      singleProjectContent.removeClass 'is-visible'
    return
  projectsSlider.on 'swipeleft', ->
    mq = checkMQ()
    if !sliderNav.find('.next').hasClass('inactive') and mq == 'desktop'
      nextSides projectsSlider
    return
  projectsSlider.on 'swiperight', ->
    mq = checkMQ()
    if !sliderNav.find('.prev').hasClass('inactive') and mq == 'desktop'
      prevSides projectsSlider
    return
