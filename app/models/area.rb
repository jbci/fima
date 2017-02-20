class Area < ApplicationRecord
  extend ActsAsTree::TreeView

  acts_as_tree order: "name"

  belongs_to :area_level
  has_many :evaluations, dependent: :destroy
  has_many :posts, dependent: :nullify

  validates_presence_of :name

  scope :comunas, -> {
                      level = AreaLevel.find_by_name('Comuna')
                      where(area_level: level)
                    }

  scope :regiones, -> {
                      level = AreaLevel.find_by_name('Región')
                      where(area_level: level)
                    }

  scope :paises, -> {
                      level = AreaLevel.find_by_name('País')
                      where(area_level: level)
                    }

  def geojson
    geom = RGeo::GeoJSON.encode(self.geom)

    {:type => "Feature",
     :geometry => geom,
     :properties => { :name => self.name}}.to_json

    # "{    \"type\": \"Feature\",    \"geometry\": { \"type\":\"MultiPolygon\",\"coordinates\":[[[[-70.57944463977933, -33.35201043855249], [-70.5789465834744, -33.352016847950644], [-70.57853151876684, -33.35202205223712], [-70.57782664678165, -33.35206588362511], [-70.57716439300188, -33.35217876450802], [-70.57613426905614, -33.35261000622381], [-70.57539537768491, -33.353072266307834], [-70.57482686446427, -33.35377631240876], [-70.57409476719351, -33.354621766224625], [-70.5734048263524, -33.35550155341402], [-70.57287021671516, -33.3557870017802], [-70.57212627103446, -33.35597063413216], [-70.57154518955801, -33.355977991655884], [-70.57092006145405, -33.35584656605392], [-70.57025348004625, -33.35571566251818], [-70.56875539680327, -33.35552552375723], [-70.5680906927863, -33.35549904985601], [-70.5675919887844, -33.35547055118897], [-70.56684794393803, -33.35565407933257], [-70.56610648196592, -33.355977054500066], [-70.5656976366491, -33.356330628629905], [-70.56537303348847, -33.35675280725994], [-70.56480067334667, -33.35724777733121], [-70.56414281382933, -33.35760448512549], [-70.56253021321419, -33.35797320974464], [-70.56025651719132, -33.35852443366445], [-70.55934589409598, -33.358675286980876], [-70.55826793212545, -33.358758492286064], [-70.55772890604446, -33.35880005457692], [-70.55742066360219, -33.35888189100855], [-70.55629387198623, -33.35889602278244], [-70.55484094449749, -33.35887069815958], [-70.55277184961447, -33.35920131630078], [-70.55033506519945, -33.359275305066504], [-70.54962055619033, -33.35993719520364], [-70.5489037228416, -33.360468517339164], [-70.5486659947588, -33.36169035921126], [-70.54771910304542, -33.363878732710404], [-70.5469054272476, -33.364803032809135], [-70.54484558861984, -33.36611828479855], [-70.54378232282097, -33.367149073254794], [-70.54251021017676, -33.368557889528034], [-70.54138982697316, -33.369747152685854], [-70.54118414162966, -33.37006892814812], [-70.5406180292668, -33.37026713786578], [-70.53958434484011, -33.3705239152361], [-70.53808921058007, -33.370507507616686], [-70.53622047124041, -33.3704958546966], [-70.53538954179297, -33.37047133949744], [-70.53422655341497, -33.37045084900643], [-70.53306592248704, -33.370569730919335], [-70.53198664677011, -33.37058305744421], [-70.5310739207544, -33.3706291173515], [-70.53032600275426, -33.37060347021884], [-70.52968117120712, -33.370526235351086], [-70.52958261072551, -33.37052449556084], [-70.52850034313788, -33.37035674849492], [-70.52753797773808, -33.37018744233771], [-70.52664586897103, -33.36991671379263], [-70.52551396739965, -33.369648926245546], [-70.52486368539148, -33.36949593204238], [-70.52443101482572, -33.36944088745074], [-70.5239990444452, -33.3694260222059], [-70.52366364252615, -33.369450236140175], [-70.5233064894654, -33.369595509091], [-70.52304520200802, -33.36973960559404], [-70.52240053011118, -33.36990842504023], [-70.5217308627316, -33.37001733601784], [-70.52108557465476, -33.37014596677065], [-70.52046309327288, -33.37021402742348], [-70.52024102636709, -33.37024430478656], [-70.51992266162064, -33.37033012143427], [-70.5194713345449, -33.37036525466219], [-70.5184958061001, -33.371378196395476], [-70.51768905194245, -33.37257856982231], [-70.51757328195576, -33.37276386975579], [-70.51786782280168, -33.37289764969951], [-70.52241063855749, -33.37496088942053], [-70.52494422568168, -33.375874087263135], [-70.5253250696899, -33.37620563253437], [-70.52598652074204, -33.376516219710524], [-70.52709333601256, -33.37714713455045], [-70.52761323571582, -33.37756532423522], [-70.52794162572503, -33.377888717286936], [-70.52874852040011, -33.37864912683587], [-70.52935115560925, -33.37951673644261], [-70.53010071057403, -33.38007385988978], [-70.53084416464448, -33.380758537317625], [-70.53234857115265, -33.38216795498643], [-70.53235176218885, -33.38216841070024], [-70.53388518400057, -33.38381617820738], [-70.5349425869608, -33.384142433558], [-70.53734044470539, -33.38536449545037], [-70.54179649338806, -33.38734910118982], [-70.5434288143457, -33.38814332876272], [-70.54379049423892, -33.388282193978334], [-70.54522399554943, -33.38879769074531], [-70.5459572898366, -33.38902305043766], [-70.54723471177365, -33.389508474904744], [-70.54743540154924, -33.38970101451097], [-70.54827821575587, -33.39007740792203], [-70.54943646671316, -33.39052092889756], [-70.54968345086844, -33.39061699108176], [-70.55080203950692, -33.391062989288265], [-70.55139404160954, -33.39129008210747], [-70.55248909016353, -33.39171131383885], [-70.5525367016816, -33.3917727148251], [-70.55331856901836, -33.391980527115145], [-70.55413744279592, -33.39232475983649], [-70.55450119949062, -33.39245638842571], [-70.55661627783223, -33.39319350209444], [-70.55873527450355, -33.39391537061909], [-70.56153457298464, -33.39489675028781], [-70.56161134683532, -33.39495554670825], [-70.56583136314369, -33.39632020341272], [-70.56974942844565, -33.39748910796158], [-70.57161418654033, -33.39804530315335], [-70.5719438738756, -33.39814367057409], [-70.58650874073975, -33.404113024492], [-70.58664482616089, -33.40416878633528], [-70.58685052794921, -33.404228287570795], [-70.59414978848419, -33.40633872582934], [-70.59595099317008, -33.4070006296957], [-70.59778065268388, -33.40767295249697], [-70.59861095324054, -33.40805676710573], [-70.59916322622668, -33.40824690410215], [-70.59967459218765, -33.408338938319346], [-70.60034151418995, -33.40836321231169], [-70.60116519593993, -33.408385458416454], [-70.60167466866523, -33.40837895493341], [-70.60226312128506, -33.40840415781802], [-70.60375976910132, -33.40877940139041], [-70.60458708154262, -33.40899883407751], [-70.60549390031939, -33.409282984216986], [-70.60586968918817, -33.409278193646365], [-70.60592499492378, -33.409277403676434], [-70.61454235757945, -33.409165537121304], [-70.61437494548315, -33.40908231218467], [-70.61261715800767, -33.40837355850383], [-70.6121117069412, -33.40799684705034], [-70.61177170942155, -33.407583187228354], [-70.61147328443217, -33.407169060276736], [-70.61096205797583, -33.406478878015285], [-70.61078439128407, -33.405853957305034], [-70.61056130616656, -33.405020696316875], [-70.6105612380054, -33.40501700327501], [-70.61054073568918, -33.403906135997524], [-70.61048631267282, -33.403210020438365], [-70.61039170061095, -33.40258409347234], [-70.61007145155887, -33.40098567592037], [-70.6092905146833, -33.399184083975854], [-70.6089371724844, -33.398038967817534], [-70.6085416346609, -33.396859526885784], [-70.60743046717847, -33.39516673963137], [-70.60585685066015, -33.39316638768526], [-70.60298404177544, -33.39052085100638], [-70.60226527632035, -33.389833309467264], [-70.60171275845339, -33.38914369238154], [-70.60145144363013, -33.388485036280315], [-70.60152114420464, -33.38775251507039], [-70.60200087050589, -33.386736028912374], [-70.60245624266389, -33.38632226307608], [-70.60281779984622, -33.38599370860705], [-70.60326242767549, -33.385326084039086], [-70.6036583664748, -33.3842757296612], [-70.60389089686716, -33.38336689563222], [-70.60388322070295, -33.3829489136604], [-70.6036188007934, -33.382116170379675], [-70.60289562928637, -33.38118488709303], [-70.60100179033032, -33.379815608837575], [-70.6004960086752, -33.37940405232841], [-70.60015618198148, -33.37899035386335], [-70.60002003716697, -33.37836502450688], [-70.60000289877777, -33.37742454467063], [-70.60010386198488, -33.37613412747415], [-70.60008910177845, -33.37533302634566], [-70.59982155448618, -33.3743261060187], [-70.59908774066254, -33.372802647069975], [-70.59819875844755, -33.37187339619811], [-70.59777787201394, -33.37156519810642], [-70.59760539063726, -33.37121907928966], [-70.5975562839608, -33.37080155499153], [-70.59762337407041, -33.36992965749384], [-70.59746697526728, -33.368189748511874], [-70.59744850828633, -33.367179541122134], [-70.59735412765151, -33.36655366957828], [-70.59734585042065, -33.366100822592614], [-70.59734012087883, -33.36578735362468], [-70.59774624262526, -33.36529437617238], [-70.59868829814624, -33.36458541836684], [-70.59958870265388, -33.36387698945029], [-70.60061117977497, -33.36302764504581], [-70.60106200662528, -33.362708287269335], [-70.60013994285339, -33.36223235293041], [-70.59909006890129, -33.361583999245646], [-70.59833403429742, -33.36110598599992], [-70.59736718487775, -33.36045640019448], [-70.59689844993258, -33.359800473500336], [-70.59672353937519, -33.35931497266426], [-70.59638326479387, -33.358866395971425], [-70.59583727034966, -33.35852507547847], [-70.59503846280442, -33.357977849439074], [-70.59448803062357, -33.35739263024312], [-70.59402450233081, -33.35701529738126], [-70.59360243443113, -33.35663750441578], [-70.59326400446703, -33.356293507328104], [-70.59300802626352, -33.35591350644924], [-70.59262751185277, -33.355535176705004], [-70.59204072943392, -33.35522908583641], [-70.59082998544937, -33.35486139484258], [-70.58978786605483, -33.35463086893503], [-70.58908108046496, -33.3545701755437], [-70.58837547459841, -33.35457927959614], [-70.58779368569623, -33.354551851244516], [-70.587252263991, -33.35445423534449], [-70.58683339692361, -33.35425051190773], [-70.58636856718522, -33.35380357129382], [-70.5860289115034, -33.35338982754586], [-70.58581704264668, -33.35314865796525], [-70.58560689518579, -33.353012005632806], [-70.58514784809948, -33.352878457297415], [-70.58468943420304, -33.352779770053004], [-70.58418821784443, -33.352611958537366], [-70.58381082107101, -33.352407769326064], [-70.583471270984, -33.351994015944946], [-70.58313352835884, -33.351684779102726], [-70.58275433428574, -33.351376069753854], [-70.58262484282936, -33.35109897234699], [-70.58251520696321, -33.35096553977134], [-70.58196197527761, -33.35117708948345], [-70.58134253600282, -33.35135911481893], [-70.58076778634909, -33.35171492453545], [-70.5801496006306, -33.35196667081187], [-70.57944463977933, -33.35201043855249]]]]   },    \"properties\": {        \"name\": \"Plaza Road Park\"    }}"
  end

  def geojson_centroid
    geom = RGeo::GeoJSON.encode(self.geom.centroid)

    {:type => "Feature",
     :geometry => geom,
     :properties => { :name => self.name}}.to_json

    # "{    \"type\": \"Feature\",    \"geometry\": { \"type\":\"MultiPolygon\",\"coordinates\":[[[[-70.57944463977933, -33.35201043855249], [-70.5789465834744, -33.352016847950644], [-70.57853151876684, -33.35202205223712], [-70.57782664678165, -33.35206588362511], [-70.57716439300188, -33.35217876450802], [-70.57613426905614, -33.35261000622381], [-70.57539537768491, -33.353072266307834], [-70.57482686446427, -33.35377631240876], [-70.57409476719351, -33.354621766224625], [-70.5734048263524, -33.35550155341402], [-70.57287021671516, -33.3557870017802], [-70.57212627103446, -33.35597063413216], [-70.57154518955801, -33.355977991655884], [-70.57092006145405, -33.35584656605392], [-70.57025348004625, -33.35571566251818], [-70.56875539680327, -33.35552552375723], [-70.5680906927863, -33.35549904985601], [-70.5675919887844, -33.35547055118897], [-70.56684794393803, -33.35565407933257], [-70.56610648196592, -33.355977054500066], [-70.5656976366491, -33.356330628629905], [-70.56537303348847, -33.35675280725994], [-70.56480067334667, -33.35724777733121], [-70.56414281382933, -33.35760448512549], [-70.56253021321419, -33.35797320974464], [-70.56025651719132, -33.35852443366445], [-70.55934589409598, -33.358675286980876], [-70.55826793212545, -33.358758492286064], [-70.55772890604446, -33.35880005457692], [-70.55742066360219, -33.35888189100855], [-70.55629387198623, -33.35889602278244], [-70.55484094449749, -33.35887069815958], [-70.55277184961447, -33.35920131630078], [-70.55033506519945, -33.359275305066504], [-70.54962055619033, -33.35993719520364], [-70.5489037228416, -33.360468517339164], [-70.5486659947588, -33.36169035921126], [-70.54771910304542, -33.363878732710404], [-70.5469054272476, -33.364803032809135], [-70.54484558861984, -33.36611828479855], [-70.54378232282097, -33.367149073254794], [-70.54251021017676, -33.368557889528034], [-70.54138982697316, -33.369747152685854], [-70.54118414162966, -33.37006892814812], [-70.5406180292668, -33.37026713786578], [-70.53958434484011, -33.3705239152361], [-70.53808921058007, -33.370507507616686], [-70.53622047124041, -33.3704958546966], [-70.53538954179297, -33.37047133949744], [-70.53422655341497, -33.37045084900643], [-70.53306592248704, -33.370569730919335], [-70.53198664677011, -33.37058305744421], [-70.5310739207544, -33.3706291173515], [-70.53032600275426, -33.37060347021884], [-70.52968117120712, -33.370526235351086], [-70.52958261072551, -33.37052449556084], [-70.52850034313788, -33.37035674849492], [-70.52753797773808, -33.37018744233771], [-70.52664586897103, -33.36991671379263], [-70.52551396739965, -33.369648926245546], [-70.52486368539148, -33.36949593204238], [-70.52443101482572, -33.36944088745074], [-70.5239990444452, -33.3694260222059], [-70.52366364252615, -33.369450236140175], [-70.5233064894654, -33.369595509091], [-70.52304520200802, -33.36973960559404], [-70.52240053011118, -33.36990842504023], [-70.5217308627316, -33.37001733601784], [-70.52108557465476, -33.37014596677065], [-70.52046309327288, -33.37021402742348], [-70.52024102636709, -33.37024430478656], [-70.51992266162064, -33.37033012143427], [-70.5194713345449, -33.37036525466219], [-70.5184958061001, -33.371378196395476], [-70.51768905194245, -33.37257856982231], [-70.51757328195576, -33.37276386975579], [-70.51786782280168, -33.37289764969951], [-70.52241063855749, -33.37496088942053], [-70.52494422568168, -33.375874087263135], [-70.5253250696899, -33.37620563253437], [-70.52598652074204, -33.376516219710524], [-70.52709333601256, -33.37714713455045], [-70.52761323571582, -33.37756532423522], [-70.52794162572503, -33.377888717286936], [-70.52874852040011, -33.37864912683587], [-70.52935115560925, -33.37951673644261], [-70.53010071057403, -33.38007385988978], [-70.53084416464448, -33.380758537317625], [-70.53234857115265, -33.38216795498643], [-70.53235176218885, -33.38216841070024], [-70.53388518400057, -33.38381617820738], [-70.5349425869608, -33.384142433558], [-70.53734044470539, -33.38536449545037], [-70.54179649338806, -33.38734910118982], [-70.5434288143457, -33.38814332876272], [-70.54379049423892, -33.388282193978334], [-70.54522399554943, -33.38879769074531], [-70.5459572898366, -33.38902305043766], [-70.54723471177365, -33.389508474904744], [-70.54743540154924, -33.38970101451097], [-70.54827821575587, -33.39007740792203], [-70.54943646671316, -33.39052092889756], [-70.54968345086844, -33.39061699108176], [-70.55080203950692, -33.391062989288265], [-70.55139404160954, -33.39129008210747], [-70.55248909016353, -33.39171131383885], [-70.5525367016816, -33.3917727148251], [-70.55331856901836, -33.391980527115145], [-70.55413744279592, -33.39232475983649], [-70.55450119949062, -33.39245638842571], [-70.55661627783223, -33.39319350209444], [-70.55873527450355, -33.39391537061909], [-70.56153457298464, -33.39489675028781], [-70.56161134683532, -33.39495554670825], [-70.56583136314369, -33.39632020341272], [-70.56974942844565, -33.39748910796158], [-70.57161418654033, -33.39804530315335], [-70.5719438738756, -33.39814367057409], [-70.58650874073975, -33.404113024492], [-70.58664482616089, -33.40416878633528], [-70.58685052794921, -33.404228287570795], [-70.59414978848419, -33.40633872582934], [-70.59595099317008, -33.4070006296957], [-70.59778065268388, -33.40767295249697], [-70.59861095324054, -33.40805676710573], [-70.59916322622668, -33.40824690410215], [-70.59967459218765, -33.408338938319346], [-70.60034151418995, -33.40836321231169], [-70.60116519593993, -33.408385458416454], [-70.60167466866523, -33.40837895493341], [-70.60226312128506, -33.40840415781802], [-70.60375976910132, -33.40877940139041], [-70.60458708154262, -33.40899883407751], [-70.60549390031939, -33.409282984216986], [-70.60586968918817, -33.409278193646365], [-70.60592499492378, -33.409277403676434], [-70.61454235757945, -33.409165537121304], [-70.61437494548315, -33.40908231218467], [-70.61261715800767, -33.40837355850383], [-70.6121117069412, -33.40799684705034], [-70.61177170942155, -33.407583187228354], [-70.61147328443217, -33.407169060276736], [-70.61096205797583, -33.406478878015285], [-70.61078439128407, -33.405853957305034], [-70.61056130616656, -33.405020696316875], [-70.6105612380054, -33.40501700327501], [-70.61054073568918, -33.403906135997524], [-70.61048631267282, -33.403210020438365], [-70.61039170061095, -33.40258409347234], [-70.61007145155887, -33.40098567592037], [-70.6092905146833, -33.399184083975854], [-70.6089371724844, -33.398038967817534], [-70.6085416346609, -33.396859526885784], [-70.60743046717847, -33.39516673963137], [-70.60585685066015, -33.39316638768526], [-70.60298404177544, -33.39052085100638], [-70.60226527632035, -33.389833309467264], [-70.60171275845339, -33.38914369238154], [-70.60145144363013, -33.388485036280315], [-70.60152114420464, -33.38775251507039], [-70.60200087050589, -33.386736028912374], [-70.60245624266389, -33.38632226307608], [-70.60281779984622, -33.38599370860705], [-70.60326242767549, -33.385326084039086], [-70.6036583664748, -33.3842757296612], [-70.60389089686716, -33.38336689563222], [-70.60388322070295, -33.3829489136604], [-70.6036188007934, -33.382116170379675], [-70.60289562928637, -33.38118488709303], [-70.60100179033032, -33.379815608837575], [-70.6004960086752, -33.37940405232841], [-70.60015618198148, -33.37899035386335], [-70.60002003716697, -33.37836502450688], [-70.60000289877777, -33.37742454467063], [-70.60010386198488, -33.37613412747415], [-70.60008910177845, -33.37533302634566], [-70.59982155448618, -33.3743261060187], [-70.59908774066254, -33.372802647069975], [-70.59819875844755, -33.37187339619811], [-70.59777787201394, -33.37156519810642], [-70.59760539063726, -33.37121907928966], [-70.5975562839608, -33.37080155499153], [-70.59762337407041, -33.36992965749384], [-70.59746697526728, -33.368189748511874], [-70.59744850828633, -33.367179541122134], [-70.59735412765151, -33.36655366957828], [-70.59734585042065, -33.366100822592614], [-70.59734012087883, -33.36578735362468], [-70.59774624262526, -33.36529437617238], [-70.59868829814624, -33.36458541836684], [-70.59958870265388, -33.36387698945029], [-70.60061117977497, -33.36302764504581], [-70.60106200662528, -33.362708287269335], [-70.60013994285339, -33.36223235293041], [-70.59909006890129, -33.361583999245646], [-70.59833403429742, -33.36110598599992], [-70.59736718487775, -33.36045640019448], [-70.59689844993258, -33.359800473500336], [-70.59672353937519, -33.35931497266426], [-70.59638326479387, -33.358866395971425], [-70.59583727034966, -33.35852507547847], [-70.59503846280442, -33.357977849439074], [-70.59448803062357, -33.35739263024312], [-70.59402450233081, -33.35701529738126], [-70.59360243443113, -33.35663750441578], [-70.59326400446703, -33.356293507328104], [-70.59300802626352, -33.35591350644924], [-70.59262751185277, -33.355535176705004], [-70.59204072943392, -33.35522908583641], [-70.59082998544937, -33.35486139484258], [-70.58978786605483, -33.35463086893503], [-70.58908108046496, -33.3545701755437], [-70.58837547459841, -33.35457927959614], [-70.58779368569623, -33.354551851244516], [-70.587252263991, -33.35445423534449], [-70.58683339692361, -33.35425051190773], [-70.58636856718522, -33.35380357129382], [-70.5860289115034, -33.35338982754586], [-70.58581704264668, -33.35314865796525], [-70.58560689518579, -33.353012005632806], [-70.58514784809948, -33.352878457297415], [-70.58468943420304, -33.352779770053004], [-70.58418821784443, -33.352611958537366], [-70.58381082107101, -33.352407769326064], [-70.583471270984, -33.351994015944946], [-70.58313352835884, -33.351684779102726], [-70.58275433428574, -33.351376069753854], [-70.58262484282936, -33.35109897234699], [-70.58251520696321, -33.35096553977134], [-70.58196197527761, -33.35117708948345], [-70.58134253600282, -33.35135911481893], [-70.58076778634909, -33.35171492453545], [-70.5801496006306, -33.35196667081187], [-70.57944463977933, -33.35201043855249]]]]   },    \"properties\": {        \"name\": \"Plaza Road Park\"    }}"
  end

  def centroid_coordinates
    centroid = (self.geom.centroid)

    {lat: centroid.y, lng: centroid.x}.to_json

    # "{    \"type\": \"Feature\",    \"geometry\": { \"type\":\"MultiPolygon\",\"coordinates\":[[[[-70.57944463977933, -33.35201043855249], [-70.5789465834744, -33.352016847950644], [-70.57853151876684, -33.35202205223712], [-70.57782664678165, -33.35206588362511], [-70.57716439300188, -33.35217876450802], [-70.57613426905614, -33.35261000622381], [-70.57539537768491, -33.353072266307834], [-70.57482686446427, -33.35377631240876], [-70.57409476719351, -33.354621766224625], [-70.5734048263524, -33.35550155341402], [-70.57287021671516, -33.3557870017802], [-70.57212627103446, -33.35597063413216], [-70.57154518955801, -33.355977991655884], [-70.57092006145405, -33.35584656605392], [-70.57025348004625, -33.35571566251818], [-70.56875539680327, -33.35552552375723], [-70.5680906927863, -33.35549904985601], [-70.5675919887844, -33.35547055118897], [-70.56684794393803, -33.35565407933257], [-70.56610648196592, -33.355977054500066], [-70.5656976366491, -33.356330628629905], [-70.56537303348847, -33.35675280725994], [-70.56480067334667, -33.35724777733121], [-70.56414281382933, -33.35760448512549], [-70.56253021321419, -33.35797320974464], [-70.56025651719132, -33.35852443366445], [-70.55934589409598, -33.358675286980876], [-70.55826793212545, -33.358758492286064], [-70.55772890604446, -33.35880005457692], [-70.55742066360219, -33.35888189100855], [-70.55629387198623, -33.35889602278244], [-70.55484094449749, -33.35887069815958], [-70.55277184961447, -33.35920131630078], [-70.55033506519945, -33.359275305066504], [-70.54962055619033, -33.35993719520364], [-70.5489037228416, -33.360468517339164], [-70.5486659947588, -33.36169035921126], [-70.54771910304542, -33.363878732710404], [-70.5469054272476, -33.364803032809135], [-70.54484558861984, -33.36611828479855], [-70.54378232282097, -33.367149073254794], [-70.54251021017676, -33.368557889528034], [-70.54138982697316, -33.369747152685854], [-70.54118414162966, -33.37006892814812], [-70.5406180292668, -33.37026713786578], [-70.53958434484011, -33.3705239152361], [-70.53808921058007, -33.370507507616686], [-70.53622047124041, -33.3704958546966], [-70.53538954179297, -33.37047133949744], [-70.53422655341497, -33.37045084900643], [-70.53306592248704, -33.370569730919335], [-70.53198664677011, -33.37058305744421], [-70.5310739207544, -33.3706291173515], [-70.53032600275426, -33.37060347021884], [-70.52968117120712, -33.370526235351086], [-70.52958261072551, -33.37052449556084], [-70.52850034313788, -33.37035674849492], [-70.52753797773808, -33.37018744233771], [-70.52664586897103, -33.36991671379263], [-70.52551396739965, -33.369648926245546], [-70.52486368539148, -33.36949593204238], [-70.52443101482572, -33.36944088745074], [-70.5239990444452, -33.3694260222059], [-70.52366364252615, -33.369450236140175], [-70.5233064894654, -33.369595509091], [-70.52304520200802, -33.36973960559404], [-70.52240053011118, -33.36990842504023], [-70.5217308627316, -33.37001733601784], [-70.52108557465476, -33.37014596677065], [-70.52046309327288, -33.37021402742348], [-70.52024102636709, -33.37024430478656], [-70.51992266162064, -33.37033012143427], [-70.5194713345449, -33.37036525466219], [-70.5184958061001, -33.371378196395476], [-70.51768905194245, -33.37257856982231], [-70.51757328195576, -33.37276386975579], [-70.51786782280168, -33.37289764969951], [-70.52241063855749, -33.37496088942053], [-70.52494422568168, -33.375874087263135], [-70.5253250696899, -33.37620563253437], [-70.52598652074204, -33.376516219710524], [-70.52709333601256, -33.37714713455045], [-70.52761323571582, -33.37756532423522], [-70.52794162572503, -33.377888717286936], [-70.52874852040011, -33.37864912683587], [-70.52935115560925, -33.37951673644261], [-70.53010071057403, -33.38007385988978], [-70.53084416464448, -33.380758537317625], [-70.53234857115265, -33.38216795498643], [-70.53235176218885, -33.38216841070024], [-70.53388518400057, -33.38381617820738], [-70.5349425869608, -33.384142433558], [-70.53734044470539, -33.38536449545037], [-70.54179649338806, -33.38734910118982], [-70.5434288143457, -33.38814332876272], [-70.54379049423892, -33.388282193978334], [-70.54522399554943, -33.38879769074531], [-70.5459572898366, -33.38902305043766], [-70.54723471177365, -33.389508474904744], [-70.54743540154924, -33.38970101451097], [-70.54827821575587, -33.39007740792203], [-70.54943646671316, -33.39052092889756], [-70.54968345086844, -33.39061699108176], [-70.55080203950692, -33.391062989288265], [-70.55139404160954, -33.39129008210747], [-70.55248909016353, -33.39171131383885], [-70.5525367016816, -33.3917727148251], [-70.55331856901836, -33.391980527115145], [-70.55413744279592, -33.39232475983649], [-70.55450119949062, -33.39245638842571], [-70.55661627783223, -33.39319350209444], [-70.55873527450355, -33.39391537061909], [-70.56153457298464, -33.39489675028781], [-70.56161134683532, -33.39495554670825], [-70.56583136314369, -33.39632020341272], [-70.56974942844565, -33.39748910796158], [-70.57161418654033, -33.39804530315335], [-70.5719438738756, -33.39814367057409], [-70.58650874073975, -33.404113024492], [-70.58664482616089, -33.40416878633528], [-70.58685052794921, -33.404228287570795], [-70.59414978848419, -33.40633872582934], [-70.59595099317008, -33.4070006296957], [-70.59778065268388, -33.40767295249697], [-70.59861095324054, -33.40805676710573], [-70.59916322622668, -33.40824690410215], [-70.59967459218765, -33.408338938319346], [-70.60034151418995, -33.40836321231169], [-70.60116519593993, -33.408385458416454], [-70.60167466866523, -33.40837895493341], [-70.60226312128506, -33.40840415781802], [-70.60375976910132, -33.40877940139041], [-70.60458708154262, -33.40899883407751], [-70.60549390031939, -33.409282984216986], [-70.60586968918817, -33.409278193646365], [-70.60592499492378, -33.409277403676434], [-70.61454235757945, -33.409165537121304], [-70.61437494548315, -33.40908231218467], [-70.61261715800767, -33.40837355850383], [-70.6121117069412, -33.40799684705034], [-70.61177170942155, -33.407583187228354], [-70.61147328443217, -33.407169060276736], [-70.61096205797583, -33.406478878015285], [-70.61078439128407, -33.405853957305034], [-70.61056130616656, -33.405020696316875], [-70.6105612380054, -33.40501700327501], [-70.61054073568918, -33.403906135997524], [-70.61048631267282, -33.403210020438365], [-70.61039170061095, -33.40258409347234], [-70.61007145155887, -33.40098567592037], [-70.6092905146833, -33.399184083975854], [-70.6089371724844, -33.398038967817534], [-70.6085416346609, -33.396859526885784], [-70.60743046717847, -33.39516673963137], [-70.60585685066015, -33.39316638768526], [-70.60298404177544, -33.39052085100638], [-70.60226527632035, -33.389833309467264], [-70.60171275845339, -33.38914369238154], [-70.60145144363013, -33.388485036280315], [-70.60152114420464, -33.38775251507039], [-70.60200087050589, -33.386736028912374], [-70.60245624266389, -33.38632226307608], [-70.60281779984622, -33.38599370860705], [-70.60326242767549, -33.385326084039086], [-70.6036583664748, -33.3842757296612], [-70.60389089686716, -33.38336689563222], [-70.60388322070295, -33.3829489136604], [-70.6036188007934, -33.382116170379675], [-70.60289562928637, -33.38118488709303], [-70.60100179033032, -33.379815608837575], [-70.6004960086752, -33.37940405232841], [-70.60015618198148, -33.37899035386335], [-70.60002003716697, -33.37836502450688], [-70.60000289877777, -33.37742454467063], [-70.60010386198488, -33.37613412747415], [-70.60008910177845, -33.37533302634566], [-70.59982155448618, -33.3743261060187], [-70.59908774066254, -33.372802647069975], [-70.59819875844755, -33.37187339619811], [-70.59777787201394, -33.37156519810642], [-70.59760539063726, -33.37121907928966], [-70.5975562839608, -33.37080155499153], [-70.59762337407041, -33.36992965749384], [-70.59746697526728, -33.368189748511874], [-70.59744850828633, -33.367179541122134], [-70.59735412765151, -33.36655366957828], [-70.59734585042065, -33.366100822592614], [-70.59734012087883, -33.36578735362468], [-70.59774624262526, -33.36529437617238], [-70.59868829814624, -33.36458541836684], [-70.59958870265388, -33.36387698945029], [-70.60061117977497, -33.36302764504581], [-70.60106200662528, -33.362708287269335], [-70.60013994285339, -33.36223235293041], [-70.59909006890129, -33.361583999245646], [-70.59833403429742, -33.36110598599992], [-70.59736718487775, -33.36045640019448], [-70.59689844993258, -33.359800473500336], [-70.59672353937519, -33.35931497266426], [-70.59638326479387, -33.358866395971425], [-70.59583727034966, -33.35852507547847], [-70.59503846280442, -33.357977849439074], [-70.59448803062357, -33.35739263024312], [-70.59402450233081, -33.35701529738126], [-70.59360243443113, -33.35663750441578], [-70.59326400446703, -33.356293507328104], [-70.59300802626352, -33.35591350644924], [-70.59262751185277, -33.355535176705004], [-70.59204072943392, -33.35522908583641], [-70.59082998544937, -33.35486139484258], [-70.58978786605483, -33.35463086893503], [-70.58908108046496, -33.3545701755437], [-70.58837547459841, -33.35457927959614], [-70.58779368569623, -33.354551851244516], [-70.587252263991, -33.35445423534449], [-70.58683339692361, -33.35425051190773], [-70.58636856718522, -33.35380357129382], [-70.5860289115034, -33.35338982754586], [-70.58581704264668, -33.35314865796525], [-70.58560689518579, -33.353012005632806], [-70.58514784809948, -33.352878457297415], [-70.58468943420304, -33.352779770053004], [-70.58418821784443, -33.352611958537366], [-70.58381082107101, -33.352407769326064], [-70.583471270984, -33.351994015944946], [-70.58313352835884, -33.351684779102726], [-70.58275433428574, -33.351376069753854], [-70.58262484282936, -33.35109897234699], [-70.58251520696321, -33.35096553977134], [-70.58196197527761, -33.35117708948345], [-70.58134253600282, -33.35135911481893], [-70.58076778634909, -33.35171492453545], [-70.5801496006306, -33.35196667081187], [-70.57944463977933, -33.35201043855249]]]]   },    \"properties\": {        \"name\": \"Plaza Road Park\"    }}"
  end

end
