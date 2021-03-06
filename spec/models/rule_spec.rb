require 'spec_helper'

describe Rule do

	describe "all"  do
		before :each do

		end

		it "gets all the cardinal placements" do
			@response = double('response').as_null_object
			Net::HTTP.stub(:get_response).and_return(@response)
			@response.stub(:body).and_return(cardinal_placement_list_xml)

			placements = CardinalPlacement.all
			placements.count.should eql 9
		end

	end

	describe "update_attributes" do
		
		it "takes a hash and updates the methods corresponding to the names with the values" do
			@placement = CardinalPlacement.new
			@placement.dretitle = "2010 Prospectus"
			params = {:dretitle => "2013 Prospectus"}
			@placement.update_attributes(params)
			@placement.dretitle.should eql "2013 Prospectus"
		end

	end

	describe "query_idol_with" do
		before :each do
			@response = double('response').as_null_object
			Net::HTTP.stub(:get_response).and_return(@response)
		end

		it "gets the xml data from idol" do
			@response.stub(:body).and_return(cardinal_placement_list_xml)
			Net::HTTP.should_receive(:get_response).and_return(@response)
			CardinalPlacement.query_idol_with("http://madeupurl.com")
		end

		it "returns the data as a hash" do
			@response.stub(:body).and_return(hit)
			hashed_values = CardinalPlacement.query_idol_with("http://madeupurl.com")
			hit_hash = hashed_values['responsedata'][0]['hit'][0]
			hit_hash['reference'][0].should eql "1345464832-AUTN-GENERATED-REF-862-74078-15920"
			hit_hash['id'][0].should eql "862"
			hit_hash['section'][0].should eql "0"
			hit_hash['weight'][0].should eql "96.00"
		end

	end

	describe "new" do
		it "makes all xml nodes attributes of the class" do
			placement = CardinalPlacement.new(attributes)
			placement.title.should eql "tardinal_placement"
			placement.reference.should eql "1345464832-AUTN-GENERATED-REF-862-74078-15920"
			placement.weight.should eql "96.00"
			placement.qmstype.should eql "1"
			placement.alwaysactive.should eql "TRUE"
			placement.qmsvalue1.should eql "https://intranet.birmingham.ac.uk/it/teams/applications/web-services/staff/tara-lamplough.aspx"
		end
	end

	def attributes
		{"reference"=>["1345464832-AUTN-GENERATED-REF-862-74078-15920"],
			"id"=>["862"],
			"section"=>["0"],
			"weight"=>["96.00"],
			"database"=>["Activated"],
			"title"=>["tardinal_placement"],
			"content"=>
		{"DOCUMENT"=>
			[{"DRETITLE"=>["tardinal_placement"],
				"QMSTYPE"=>["1"],
				"ALWAYSACTIVE"=>["TRUE"],
				"QMSVALUE1"=>
			["https://intranet.birmingham.ac.uk/it/teams/applications/web-services/staff/tara-lamplough.aspx"],
				"QMSVALUE2"=>["3"],
				"QMSAGENTBOOL"=>["tara AND needs AND to AND know AND everything"],
				"DRECONTENT"=>["tara needs to know everything\n\n\t\t"],
				"DREREFERENCE"=>
			["1345464832-AUTN-GENERATED-REF-862-74078-15920"]}]}}
	end

	def hit
		"<?xml version='1.0' encoding='UTF-8' ?><autnresponse xmlns:autn='http://schemas.autonomy.com/aci/'><action>QUERY</action><response>SUCCESS</response><responsedata>

		<autn:numhits>1</autn:numhits><autn:hit><autn:reference>1345464832-AUTN-GENERATED-REF-862-74078-15920</autn:reference><autn:id>862</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>tardinal_placement</autn:title><autn:content><DOCUMENT><DRETITLE>tardinal_placement</DRETITLE><QMSTYPE>1</QMSTYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSVALUE1>https://intranet.birmingham.ac.uk/it/teams/applications/web-services/staff/tara-lamplough.aspx</QMSVALUE1><QMSVALUE2>3</QMSVALUE2><QMSAGENTBOOL>tara AND needs AND to AND know AND everything</QMSAGENTBOOL><DRECONTENT>tara needs to know everything

		</DRECONTENT><DREREFERENCE>1345464832-AUTN-GENERATED-REF-862-74078-15920</DREREFERENCE></DOCUMENT></autn:content></autn:hit></responsedata></autnresponse>"
	end

	def	cardinal_placement_list_xml
		"<?xml version='1.0' encoding='UTF-8' ?><autnresponse xmlns:autn='http://schemas.autonomy.com/aci/'><action>QUERY</action><response>SUCCESS</response><responsedata>
		<autn:numhits>9</autn:numhits><autn:hit><autn:reference>1345464832-AUTN-GENERATED-REF-862-74078-15920</autn:reference><autn:id>862</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>tardinal_placement</autn:title><autn:content><DOCUMENT><DRETITLE>tardinal_placement</DRETITLE><QMSTYPE>1</QMSTYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSVALUE1>https://intranet.birmingham.ac.uk/it/teams/applications/web-services/staff/tara-lamplough.aspx</QMSVALUE1><QMSVALUE2>3</QMSVALUE2><QMSAGENTBOOL>tara AND needs AND to AND know AND everything</QMSAGENTBOOL><DRECONTENT>tara needs to know everything

		</DRECONTENT><DREREFERENCE>1345464832-AUTN-GENERATED-REF-862-74078-15920</DREREFERENCE></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>593877363801070230</autn:reference><autn:id>848</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>ZGF2ZSBzbWl0aGh0dHA6Ly93d3cuYmlybWluZ2hhbS5hYy51ay9zdGFmZi9wcm9maWxlcy9jaGVtaWNhbC1lbmdpbmVlcmluZy9zaW1tb25zLW1hcmsuYXNweA==</autn:title><autn:content><DOCUMENT><DREREFERENCE>593877363801070230</DREREFERENCE><DRETITLE>ZGF2ZSBzbWl0aGh0dHA6Ly93d3cuYmlybWluZ2hhbS5hYy51ay9zdGFmZi9wcm9maWxlcy9jaGVtaWNhbC1lbmdpbmVlcmluZy9zaW1tb25zLW1hcmsuYXNweA==</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>dave smith BAKA BUBBL PARAU PLANAR SIMMON HANRATTI STITT CFD FRYER WONG HYSTERESI ANNULAR EXP MARSTON PLIF DECENT BBSRC JET PEPT MULTIPHAS UDDIN VESSEL TSOLIGKA BIOFILM BARIGOU BIOCATALYST FOUL PHY FLUORESCENT UEA IFSET PIV AZZOPARDI GRANULAR MATTHEI UNILEV GAMBL AERAT AGIT BIOTRANSFORM DROPLET PROCTER DROP FLUID CURTAIN CES BRIDSON MEHAUDEN REACTOR JFOODENG</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>DAVE SMITH BAKA BUBBL PARAU PLANAR SIMMON HANRATTI STITT CFD FRYER WONG HYSTERESI ANNULAR EXP MARSTON PLIF DECENT BBSRC JET PEPT MULTIPHAS UDDIN VESSEL TSOLIGKA BIOFILM BARIGOU BIOCATALYST FOUL PHY FLUORESCENT UEA IFSET PIV AZZOPARDI GRANULAR MATTHEI UNILEV GAMBL AERAT AGIT BIOTRANSFORM DROPLET PROCTER DROP FLUID CURTAIN CES BRIDSON MEHAUDEN REACTOR JFOODENG
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.birmingham.ac.uk/staff/profiles/chemical-engineering/simmons-mark.aspx</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>dave smith OR BAKA OR BUBBL OR PARAU OR PLANAR OR SIMMON OR HANRATTI OR STITT OR CFD OR FRYER OR WONG OR HYSTERESI OR ANNULAR OR EXP OR MARSTON OR PLIF OR DECENT OR BBSRC OR JET OR PEPT OR MULTIPHAS OR UDDIN OR VESSEL OR TSOLIGKA OR BIOFILM OR BARIGOU OR BIOCATALYST OR FOUL OR PHY OR FLUORESCENT OR UEA OR IFSET OR PIV OR AZZOPARDI OR GRANULAR OR MATTHEI OR UNILEV OR GAMBL OR AERAT OR AGIT OR BIOTRANSFORM OR DROPLET OR PROCTER OR DROP OR FLUID OR CURTAIN OR CES OR BRIDSON OR MEHAUDEN OR REACTOR OR JFOODENG</QMSAGENTBOOL><QMSVALUE2>1</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>393542817343784342</autn:reference><autn:id>845</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>d2VsY29tZWh0dHA6Ly93d3cuYmlybWluZ2hhbS5hYy51ay93ZWxjb21lL2luZGV4LmFzcHg=</autn:title><autn:content><DOCUMENT><DREREFERENCE>393542817343784342</DREREFERENCE><DRETITLE>d2VsY29tZWh0dHA6Ly93d3cuYmlybWluZ2hhbS5hYy51ay93ZWxjb21lL2luZGV4LmFzcHg=</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>welcome HELP GREAT DOCTOR WELCOM CHOCOL REGIST CHILDREN BEFOR PREPAR WHAT MATUR YEAR DAUGHTER COMPLET STAI REGISTR PARENT SERVIC SEE ONLIN AVAIL WAR DISABL ADMINISTR SHOP FORM VICE ARRIV BEAUTI NEAR SITE SETTL STUDENT LOCAL EVENT EASI TRAVEL QUESTION READ FUND MOVE EVERYTH SON START CHANCELLOR CHECK CAMPU LET KNOW FEEDBACK</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>WELCOME HELP GREAT DOCTOR WELCOM CHOCOL REGIST CHILDREN BEFOR PREPAR MATUR YEAR DAUGHTER COMPLET STAI REGISTR PARENT SERVIC SEE ONLIN AVAIL WAR DISABL ADMINISTR SHOP FORM VICE ARRIV BEAUTI SETTL STUDENT LOCAL EVENT EASI TRAVEL QUESTION READ FUND MOVE EVERYTH SON START CHANCELLOR CHECK CAMPU LET KNOW FEEDBACK
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.birmingham.ac.uk/welcome/index.aspx</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>welcome OR HELP OR GREAT OR DOCTOR OR WELCOM OR CHOCOL OR REGIST OR CHILDREN OR BEFOR OR PREPAR OR WHAT OR MATUR OR YEAR OR DAUGHTER OR COMPLET OR STAI OR REGISTR OR PARENT OR SERVIC OR SEE OR ONLIN OR AVAIL OR WAR OR DISABL OR ADMINISTR OR SHOP OR FORM OR VICE OR ARRIV OR BEAUTI OR NEAR OR SITE OR SETTL OR STUDENT OR LOCAL OR EVENT OR EASI OR TRAVEL OR QUESTION OR READ OR FUND OR MOVE OR EVERYTH OR SON OR START OR CHANCELLOR OR CHECK OR CAMPU OR LET OR KNOW OR FEEDBACK</QMSAGENTBOOL><QMSVALUE2>1</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>592730395217561270</autn:reference><autn:id>836</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>ZnJlZWRvbSBvZiBzcGVlY2hodHRwOi8vd3d3LmNzLmJoYW0uYWMudWsvJTdFYXhzL2xveWFsdHkuaHRtbA==</autn:title><autn:content><DOCUMENT><DREREFERENCE>592730395217561270</DREREFERENCE><DRETITLE>ZnJlZWRvbSBvZiBzcGVlY2hodHRwOi8vd3d3LmNzLmJoYW0uYWMudWsvJTdFYXhzL2xveWFsdHkuaHRtbA==</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>freedom of speech LOYALTI OFFENT RIPPL MEEK LIBEL SUPERIOR COMPLACENT BILLION HOBBI MINIST UPSET INCIT PAID PENAL DUTI AA HORS SOMEWHER HARM FREEDOM CRANKI SILLI BONNET PET MISTAK STAGNAT ARTICUL ERRON DISLOYALTI CRITICIST DISLOY PROMULG ANYHOW GOVER INJUSTIC EXPOUND OCCASION PROUD WHATEV WORRI EARTH PROCLAIM EXCESS VIOLENT CHANC BEE PERCENTAG PRONOUNC VOTE RESIST</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>FREEDOM SPEECH LOYALTI OFFENT RIPPL MEEK LIBEL SUPERIOR COMPLACENT BILLION HOBBI MINIST UPSET INCIT PAID PENAL DUTI AA HORS SOMEWHER HARM FREEDOM CRANKI SILLI BONNET PET MISTAK STAGNAT ARTICUL ERRON DISLOYALTI CRITICIST DISLOY PROMULG ANYHOW GOVER INJUSTIC EXPOUND OCCASION PROUD WHATEV WORRI EARTH PROCLAIM EXCESS VIOLENT CHANC BEE PERCENTAG PRONOUNC VOTE RESIST
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.cs.bham.ac.uk/%7Eaxs/loyalty.html</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>freedom of speech OR LOYALTI OR OFFENT OR RIPPL OR MEEK OR LIBEL OR SUPERIOR OR COMPLACENT OR BILLION OR HOBBI OR MINIST OR UPSET OR INCIT OR PAID OR PENAL OR DUTI OR AA OR HORS OR SOMEWHER OR HARM OR FREEDOM OR CRANKI OR SILLI OR BONNET OR PET OR MISTAK OR STAGNAT OR ARTICUL OR ERRON OR DISLOYALTI OR CRITICIST OR DISLOY OR PROMULG OR ANYHOW OR GOVER OR INJUSTIC OR EXPOUND OR OCCASION OR PROUD OR WHATEV OR WORRI OR EARTH OR PROCLAIM OR EXCESS OR VIOLENT OR CHANC OR BEE OR PERCENTAG OR PRONOUNC OR VOTE OR RESIST</QMSAGENTBOOL><QMSVALUE2>10</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>938389032562225184</autn:reference><autn:id>834</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>ZnJlZWRvbSBvZiBzcGVlY2hodHRwOi8vd3d3LmNzLmJoYW0uYWMudWsvfmF4cy9sb3lhbHR5Lmh0bWw=</autn:title><autn:content><DOCUMENT><DREREFERENCE>938389032562225184</DREREFERENCE><DRETITLE>ZnJlZWRvbSBvZiBzcGVlY2hodHRwOi8vd3d3LmNzLmJoYW0uYWMudWsvfmF4cy9sb3lhbHR5Lmh0bWw=</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>freedom of speech LOYALTI OFFENT RIPPL MEEK LIBEL SUPERIOR COMPLACENT BILLION HOBBI MINIST UPSET INCIT PAID PENAL DUTI AA HORS SOMEWHER HARM FREEDOM CRANKI SILLI BONNET PET MISTAK STAGNAT ARTICUL ERRON DISLOYALTI CRITICIST DISLOY PROMULG ANYHOW GOVER INJUSTIC EXPOUND OCCASION PROUD WHATEV WORRI EARTH PROCLAIM EXCESS VIOLENT CHANC BEE PERCENTAG PRONOUNC VOTE RESIST</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>FREEDOM SPEECH LOYALTI OFFENT RIPPL MEEK LIBEL SUPERIOR COMPLACENT BILLION HOBBI MINIST UPSET INCIT PAID PENAL DUTI AA HORS SOMEWHER HARM FREEDOM CRANKI SILLI BONNET PET MISTAK STAGNAT ARTICUL ERRON DISLOYALTI CRITICIST DISLOY PROMULG ANYHOW GOVER INJUSTIC EXPOUND OCCASION PROUD WHATEV WORRI EARTH PROCLAIM EXCESS VIOLENT CHANC BEE PERCENTAG PRONOUNC VOTE RESIST
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.cs.bham.ac.uk/~axs/loyalty.html</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>freedom of speech OR LOYALTI OR OFFENT OR RIPPL OR MEEK OR LIBEL OR SUPERIOR OR COMPLACENT OR BILLION OR HOBBI OR MINIST OR UPSET OR INCIT OR PAID OR PENAL OR DUTI OR AA OR HORS OR SOMEWHER OR HARM OR FREEDOM OR CRANKI OR SILLI OR BONNET OR PET OR MISTAK OR STAGNAT OR ARTICUL OR ERRON OR DISLOYALTI OR CRITICIST OR DISLOY OR PROMULG OR ANYHOW OR GOVER OR INJUSTIC OR EXPOUND OR OCCASION OR PROUD OR WHATEV OR WORRI OR EARTH OR PROCLAIM OR EXCESS OR VIOLENT OR CHANC OR BEE OR PERCENTAG OR PRONOUNC OR VOTE OR RESIST</QMSAGENTBOOL><QMSVALUE2>9</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>199121461600113962</autn:reference><autn:id>815</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>Y291cnNlIHN0dWRlbnRzIGluZGV4aHR0cDovL3d3dy5iaXJtaW5naGFtLmFjLnVrL0RvY3VtZW50cy9zdHVkZW50cy9wb3N0Z3JhZHVhdGUtcHJvc3BlY3R1cy0yMDEyLnBkZg==</autn:title><autn:content><DOCUMENT><DREREFERENCE>199121461600113962</DREREFERENCE><DRETITLE>Y291cnNlIHN0dWRlbnRzIGluZGV4aHR0cDovL3d3dy5iaXJtaW5naGFtLmFjLnVrL0RvY3VtZW50cy9zdHVkZW50cy9wb3N0Z3JhZHVhdGUtcHJvc3BlY3R1cy0yMDEyLnBkZg==</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>course students index DOCTOR CONTEMPORARI FELD DISCIPLIN OUTSTAND CERTIFC MPHIL DISSERT DL SPECIALIST MASTER QUALIFC SCHOLARSHIP POSTGRADU VIBRANT FEE SIGNIFC MSC PT ADMINISTR MRE FRST OVERSEA INDUSTRI FTPT MRS ADVIC OFFC DISTANC STUDENTSHIP SPECIFC GRADUAT PROSPECTU INTERDISCIPLINARI CORE FVE TAUGHT FT MEDIEV DIPLOMA ARCHAEOLOGI PHD SEMINAR EXCELLENT FNANCIALSUPPORT DENTAL UNDERTAK DURAT ENVIRONMENT FNANC</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>COURSE STUDENTS INDEX DOCTOR CONTEMPORARI FELD DISCIPLIN OUTSTAND CERTIFC MPHIL DISSERT DL SPECIALIST MASTER QUALIFC SCHOLARSHIP POSTGRADU VIBRANT FEE SIGNIFC MSC PT ADMINISTR MRE FRST OVERSEA INDUSTRI FTPT MRS ADVIC OFFC DISTANC STUDENTSHIP SPECIFC GRADUAT PROSPECTU INTERDISCIPLINARI CORE FVE TAUGHT FT MEDIEV DIPLOMA ARCHAEOLOGI PHD SEMINAR EXCELLENT FNANCIALSUPPORT DENTAL UNDERTAK DURAT ENVIRONMENT FNANC
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.birmingham.ac.uk/Documents/students/postgraduate-prospectus-2012.pdf</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>course students index OR DOCTOR OR CONTEMPORARI OR FELD OR DISCIPLIN OR OUTSTAND OR CERTIFC OR MPHIL OR DISSERT OR DL OR SPECIALIST OR MASTER OR QUALIFC OR SCHOLARSHIP OR POSTGRADU OR VIBRANT OR FEE OR SIGNIFC OR MSC OR PT OR ADMINISTR OR MRE OR FRST OR OVERSEA OR INDUSTRI OR FTPT OR MRS OR ADVIC OR OFFC OR DISTANC OR STUDENTSHIP OR SPECIFC OR GRADUAT OR PROSPECTU OR INTERDISCIPLINARI OR CORE OR FVE OR TAUGHT OR FT OR MEDIEV OR DIPLOMA OR ARCHAEOLOGI OR PHD OR SEMINAR OR EXCELLENT OR FNANCIALSUPPORT OR DENTAL OR UNDERTAK OR DURAT OR ENVIRONMENT OR FNANC</QMSAGENTBOOL><QMSVALUE2>18</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>361584832350749129</autn:reference><autn:id>739</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>Y291cnNlaHR0cDovL3d3dy5iaXJtaW5naGFtLmFjLnVrL0RvY3VtZW50cy9zdHVkZW50cy9wb3N0Z3JhZHVhdGUtcHJvc3BlY3R1cy0yMDEyLnBkZg==</autn:title><autn:content><DOCUMENT><DREREFERENCE>361584832350749129</DREREFERENCE><DRETITLE>Y291cnNlaHR0cDovL3d3dy5iaXJtaW5naGFtLmFjLnVrL0RvY3VtZW50cy9zdHVkZW50cy9wb3N0Z3JhZHVhdGUtcHJvc3BlY3R1cy0yMDEyLnBkZg==</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>course ADMISS DOCTOR CONTEMPORARI FELD DISCIPLIN CERTIFC OUTSTAND MPHIL DISSERT FNANCIAL DL BENEFT SPECIALIST MASTER QUALIFC SCHOLARSHIP VIBRANT POSTGRADU FEE SIGNIFC MSC PT MRE FRST OVERSEA ESRC FTPT OFFC DISTANC STUDENTSHIP INTERDISCIPLINARI PROSPECTU SPECIFC CORE FVE TAUGHT FT MEDIEV DIPLOMA ARCHAEOLOGI SUITABL PRACTITION FNANCIALSUPPORT MATHEMAT DENTAL DURAT RELIGION PG ENVIRONMENT FNANC</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>COURSE ADMISS DOCTOR CONTEMPORARI FELD DISCIPLIN CERTIFC OUTSTAND MPHIL DISSERT FNANCIAL DL BENEFT SPECIALIST MASTER QUALIFC SCHOLARSHIP VIBRANT POSTGRADU FEE SIGNIFC MSC PT MRE FRST OVERSEA ESRC FTPT OFFC DISTANC STUDENTSHIP INTERDISCIPLINARI PROSPECTU SPECIFC CORE FVE TAUGHT FT MEDIEV DIPLOMA ARCHAEOLOGI SUITABL PRACTITION FNANCIALSUPPORT MATHEMAT DENTAL DURAT RELIGION PG ENVIRONMENT FNANC
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.birmingham.ac.uk/Documents/students/postgraduate-prospectus-2012.pdf</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>course OR ADMISS OR DOCTOR OR CONTEMPORARI OR FELD OR DISCIPLIN OR CERTIFC OR OUTSTAND OR MPHIL OR DISSERT OR FNANCIAL OR DL OR BENEFT OR SPECIALIST OR MASTER OR QUALIFC OR SCHOLARSHIP OR VIBRANT OR POSTGRADU OR FEE OR SIGNIFC OR MSC OR PT OR MRE OR FRST OR OVERSEA OR ESRC OR FTPT OR OFFC OR DISTANC OR STUDENTSHIP OR INTERDISCIPLINARI OR PROSPECTU OR SPECIFC OR CORE OR FVE OR TAUGHT OR FT OR MEDIEV OR DIPLOMA OR ARCHAEOLOGI OR SUITABL OR PRACTITION OR FNANCIALSUPPORT OR MATHEMAT OR DENTAL OR DURAT OR RELIGION OR PG OR ENVIRONMENT OR FNANC</QMSAGENTBOOL><QMSVALUE2>7</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>787040277516330659</autn:reference><autn:id>732</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>cHJvc3BlY3R1c2h0dHA6Ly93d3cuYmlybWluZ2hhbS5hYy51ay9zdHVkZW50cy9wcm9zcGVjdHVzLmFzcHg=</autn:title><autn:content><DOCUMENT><DREREFERENCE>787040277516330659</DREREFERENCE><DRETITLE>cHJvc3BlY3R1c2h0dHA6Ly93d3cuYmlybWluZ2hhbS5hYy51ay9zdHVkZW50cy9wcm9zcGVjdHVzLmFzcHg=</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>prospectus HEAR OVER LATE REGIST DAI MAIL CLICK APP INDIC LOOK BIRMINGHAM VISUAL FREE IPHON SEE SCAN DEEPER STORE LIKE LIFE REQU PROSPECTU KEPT WATCH YOUV ICON WHEREV INTER BELOW LINK EVENT LIST JOIN TRY AUGMENT COME COVER OPEN PLEAS LEVEL UNDERGRADU TALK DOWNLOAD CAMPU REALITI IPAD WEVE DATE THANK IMAG</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>PROSPECTUS HEAR OVER LATE REGIST DAI MAIL CLICK APP INDIC LOOK BIRMINGHAM VISUAL FREE IPHON SEE SCAN DEEPER STORE LIKE LIFE REQU PROSPECTU KEPT WATCH YOUV ICON WHEREV INTER BELOW LINK EVENT LIST JOIN TRY AUGMENT COME COVER OPEN PLEAS LEVEL UNDERGRADU TALK DOWNLOAD CAMPU REALITI IPAD WEVE DATE THANK IMAG
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.birmingham.ac.uk/students/prospectus.aspx</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>prospectus OR HEAR OR OVER OR LATE OR REGIST OR DAI OR MAIL OR CLICK OR APP OR INDIC OR LOOK OR BIRMINGHAM OR VISUAL OR FREE OR IPHON OR SEE OR SCAN OR DEEPER OR STORE OR LIKE OR LIFE OR REQU OR PROSPECTU OR KEPT OR WATCH OR YOUV OR ICON OR WHEREV OR INTER OR BELOW OR LINK OR EVENT OR LIST OR JOIN OR TRY OR AUGMENT OR COME OR COVER OR OPEN OR PLEAS OR LEVEL OR UNDERGRADU OR TALK OR DOWNLOAD OR CAMPU OR REALITI OR IPAD OR WEVE OR DATE OR THANK OR IMAG</QMSAGENTBOOL><QMSVALUE2>1</QMSVALUE2></DOCUMENT></autn:content></autn:hit><autn:hit><autn:reference>219165648350337207</autn:reference><autn:id>728</autn:id><autn:section>0</autn:section><autn:weight>96.00</autn:weight><autn:database>Activated</autn:database><autn:title>bWFwaHR0cDovL3d3dy5iaXJtaW5naGFtLmFjLnVrL2NvbnRhY3QvZGlyZWN0aW9ucy9pbmRleC5hc3B4</autn:title><autn:content><DOCUMENT><DREREFERENCE>219165648350337207</DREREFERENCE><DRETITLE>bWFwaHR0cDovL3d3dy5iaXJtaW5naGFtLmFjLnVrL2NvbnRhY3QvZGlyZWN0aW9ucy9pbmRleC5hc3B4</DRETITLE><DREDBNAME>ACTIVATED</DREDBNAME><BOOLEANRESTRICTION>map ATMOSPHER DIRECT GREEN CHILDREN CAMPUS MATUR MILE LANDSCAP AVON LAKE EDGBASTON SPACIOUS CROFT SHAKESPEAR DENTISTRI FACIL OWN BUILD TREE TOWN SEL HISTOR SHARE CHURCH VALE LAWN MASON WALKWAI ACR OAK WILDLIF HOSPIT STREET UPON LOCAT SITE INSTITUT SET MINUT PARKLAND HOUS WALK STRATFORD CENTR HEART VILLAG MAP DENTAL JUST CAMPU</BOOLEANRESTRICTION><THRESHOLD>20</THRESHOLD><DRECONTENT>MAP ATMOSPHER DIRECT GREEN CHILDREN CAMPUS MATUR MILE LANDSCAP AVON LAKE EDGBASTON SPACIOUS CROFT SHAKESPEAR DENTISTRI FACIL OWN BUILD TREE TOWN SEL HISTOR SHARE CHURCH VALE LAWN MASON WALKWAI ACR OAK WILDLIF HOSPIT STREET UPON LOCAT SITE INSTITUT SET MINUT PARKLAND HOUS WALK STRATFORD CENTR HEART VILLAG MAP DENTAL JUST CAMPU
		</DRECONTENT><DREOUTPUTENCODING>UTF8</DREOUTPUTENCODING><QMSVALUE1>http://www.birmingham.ac.uk/contact/directions/index.aspx</QMSVALUE1><QMSTYPE>1</QMSTYPE><DRELANGUAGETYPE>English</DRELANGUAGETYPE><ALWAYSACTIVE>TRUE</ALWAYSACTIVE><QMSAGENTBOOL>map OR ATMOSPHER OR DIRECT OR GREEN OR CHILDREN OR CAMPUS OR MATUR OR MILE OR LANDSCAP OR AVON OR LAKE OR EDGBASTON OR SPACIOUS OR CROFT OR SHAKESPEAR OR DENTISTRI OR FACIL OR OWN OR BUILD OR TREE OR TOWN OR SEL OR HISTOR OR SHARE OR CHURCH OR VALE OR LAWN OR MASON OR WALKWAI OR ACR OR OAK OR WILDLIF OR HOSPIT OR STREET OR UPON OR LOCAT OR SITE OR INSTITUT OR SET OR MINUT OR PARKLAND OR HOUS OR WALK OR STRATFORD OR CENTR OR HEART OR VILLAG OR MAP OR DENTAL OR JUST OR CAMPU</QMSAGENTBOOL><QMSVALUE2>1</QMSVALUE2></DOCUMENT></autn:content></autn:hit></responsedata></autnresponse>
		"	
	end


end
