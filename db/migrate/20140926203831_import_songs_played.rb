class ImportSongsPlayed < ActiveRecord::Migration
    DATA_TO_IMPORT = [
      {"youtube_id"=>"ESXgJ9-H-2U", "title"=>"Kiesza - Hideaway (Official Video)", "times_played"=>44},
      {"youtube_id"=>"ebXbLfLACGM", "title"=>"Calvin Harris - Summer", "times_played"=>43},
      {"youtube_id"=>"TUTZebZIun8", "title"=>"The Glorious Sons - Mama (Official)", "times_played"=>41},
      {"youtube_id"=>"Gz2GVlQkn4Q", "title"=>"KONGOS - Come With Me Now", "times_played"=>37},
      {"youtube_id"=>"dHErDucj80o", "title"=>"Flight Facilities - Crave You (Adventure Club Dubstep Remix)", "times_played"=>36},
      {"youtube_id"=>"-arVgLHTr10", "title"=>"The Glorious Sons - White Noise (Official Video)", "times_played"=>31},
      {"youtube_id"=>"MYSVMgRr6pw", "title"=>"Hozier - Take Me To Church", "times_played"=>30},
      {"youtube_id"=>"AmEIemQfk34", "title"=>"Tiësto - Wasted ft. Matthew Koma", "times_played"=>30},
      {"youtube_id"=>"TMbyWSGYUgc", "title"=>"The Killers - Runaways", "times_played"=>22},
      {"youtube_id"=>"RMAG6KhH35U", "title"=>"Puscifer - The Green Valley", "times_played"=>22},
      {"youtube_id"=>"NAXz2z4giws", "title"=>"(HQ) Pretty Lights - Country Roads (Remix) [2011 Remixes] (John Denver)", "times_played"=>13},
      {"youtube_id"=>"uHNMdbHzYoI", "title"=>"Stolen Dance - Milky Chance (Lyrics)", "times_played"=>9},
      {"youtube_id"=>"4306i99LMXo", "title"=>"Edward Sharpe and the Magnetic Zeros - Home [Official Video]", "times_played"=>8},
      {"youtube_id"=>"bpOSxM0rNPM", "title"=>"Arctic Monkeys - Do I Wanna Know? (Official Video)", "times_played"=>7},
      {"youtube_id"=>"VZMfhtKa-wo", "title"=>"NERO 'PROMISES' (SKRILLEX AND NERO REMIX)", "times_played"=>7},
      {"youtube_id"=>"5NV6Rdv1a3I", "title"=>"Get Lucky (Official Audio)", "times_played"=>6},
      {"youtube_id"=>"y6Sxv-sUYtM", "title"=>"Pharrell Williams - Happy (Official Music Video)", "times_played"=>6},
      {"youtube_id"=>"oMRZp7cp79g", "title"=>"C2C - Who Are You feat. Olivier Daysoul", "times_played"=>6},
      {"youtube_id"=>"61EkGm__esw", "title"=>"Hey Rosetta! - Carry Me Home", "times_played"=>6},
      {"youtube_id"=>"8MR9OH6BjOo", "title"=>"Red Hot Chili Peppers - Dani California", "times_played"=>6},
      {"youtube_id"=>"5y_KJAg8bHI", "title"=>"Avicii - Wake Me Up (Lyric Video)", "times_played"=>6},
      {"youtube_id"=>"ZgRnLM9Vi24", "title"=>"Above & Beyond feat. Richard Bedford \"Thing Called Love\" Official Music Video", "times_played"=>5},
      {"youtube_id"=>"rq_ogKO8odA", "title"=>"HEY ROSETTA! - YOUNG GLASS", "times_played"=>5},
      {"youtube_id"=>"6Ip9d3TNYso", "title"=>"Hey Rosetta - Welcome", "times_played"=>5},
      {"youtube_id"=>"1C816p-KTNk", "title"=>"Vance Joy - \"Mess is Mine\" [Official Video]", "times_played"=>5},
      {"youtube_id"=>"MbVZYpkOxAk", "title"=>"Arkells - Never Thought That This Would Happen", "times_played"=>5},
      {"youtube_id"=>"9f06QZCVUHg", "title"=>"Bryan Adams - Summer of 69", "times_played"=>5},
      {"youtube_id"=>"9_5_AD9wXuY", "title"=>"The beach boys - Kokomo", "times_played"=>5},
      {"youtube_id"=>"sPJD3qcIL7s", "title"=>"SPIRIT OF THE WEST - Home For A Rest", "times_played"=>5},
      {"youtube_id"=>"bltr_Dsk5EY", "title"=>"Afrojack - Ten Feet Tall (Lyric Video) ft. Wrabel", "times_played"=>5},
      {"youtube_id"=>"oC-GflRB0y4", "title"=>"David Guetta & Showtek - Bad ft. Vassy (Official Audio)", "times_played"=>5},
      {"youtube_id"=>"eDWGp0mrmXk", "title"=>"Dirty Heads - \"My Sweet Summer\" (Official Video)", "times_played"=>5},
      {"youtube_id"=>"BS46C2z5lVE", "title"=>"Route 94 - My Love (Official Video) ft. Jess Glynne", "times_played"=>5},
      {"youtube_id"=>"6MH9qWemtPo", "title"=>"Mr Probz - Waves (Official Video) [Robin Schulz Remix]", "times_played"=>5},
      {"youtube_id"=>"IhyUBDkxrNc", "title"=>"Afrojack - Ten Feet Tall ft. Wrabel (BORGEOUS Remix)", "times_played"=>5},
      {"youtube_id"=>"eZxo9mrWgR8", "title"=>"Clarity - Zedd (Lyrics) [HD]", "times_played"=>5},
      {"youtube_id"=>"pZ9KfKx8PmM", "title"=>"bran van 3000 - Drinkin in LA", "times_played"=>5},
      {"youtube_id"=>"x3ab6jnPb6k", "title"=>"Puscifer - Tiny Monsters", "times_played"=>5},
      {"youtube_id"=>"Cr1aamc4Uec", "title"=>"ilvekyo - downtown girls (live)", "times_played"=>5},
      {"youtube_id"=>"vsEJxHVM1W0", "title"=>"Reuben And The Dark - Rolling Stone [Official Video]", "times_played"=>4},
      {"youtube_id"=>"93ASUImTedo", "title"=>"Disclosure - Latch feat. Sam Smith  (Official Video)", "times_played"=>4},
      {"youtube_id"=>"Iay9gyLNdBw", "title"=>"Jet ~ Cold Hard Bitch ~ Music Video", "times_played"=>4},
      {"youtube_id"=>"4tj8zn3X0xA", "title"=>"Lustra- Scotty Doesn't Know Lyrics", "times_played"=>4},
      {"youtube_id"=>"7QODOX7JNLk", "title"=>"Cazzette  -  Beam Me Up (Kill Mode) (Radio Edit)", "times_played"=>4},
      {"youtube_id"=>"BwWzSyxNc9I", "title"=>"ZHU - Faded", "times_played"=>4},
      {"youtube_id"=>"sZTpLvsYYHw", "title"=>"The Killers - All These Things That I've Done", "times_played"=>4},
      {"youtube_id"=>"ZyhrYis509A", "title"=>"Aqua - Barbie Girl", "times_played"=>4},
      {"youtube_id"=>"PZbkF-15ObM", "title"=>"C2C - Delta (official Video)", "times_played"=>4},
      {"youtube_id"=>"IxxstCcJlsc", "title"=>"Zedd - Clarity (Official Video) ft. Foxes", "times_played"=>4},
      {"youtube_id"=>"SDTZ7iX4vTQ", "title"=>"Foster The People - Pumped up Kicks", "times_played"=>4},
      {"youtube_id"=>"qEa5C3P_GIY", "title"=>"Above & Beyond feat. Richard Bedford - Sun and Moon (Original Mix)", "times_played"=>4},
      {"youtube_id"=>"pUjE9H8QlA4", "title"=>"Mr. Probz - Waves (Robin Schulz Remix Radio Edit)", "times_played"=>4},
      {"youtube_id"=>"ohqhob4FD20", "title"=>"John Lennon - Arkells", "times_played"=>4},
      {"youtube_id"=>"nItYgMJBMA0", "title"=>"Kings Of Leon - Temple", "times_played"=>4},
      {"youtube_id"=>"IcrbM1l_BoI", "title"=>"Avicii - Wake Me Up (Official Video)", "times_played"=>4},
      {"youtube_id"=>"VMPxMfYRaqs", "title"=>"Julien Creance - Heatwave (Original)", "times_played"=>4},
      {"youtube_id"=>"DHEOF_rcND8", "title"=>"Edward Sharpe & The Magnetic Zeros - Home", "times_played"=>4},
      {"youtube_id"=>"JDMfpeUWS3Q", "title"=>"Adventure Club - Wonder (feat. The Kite String Tangle)", "times_played"=>4},
      {"youtube_id"=>"Zi_XLOBDo_Y", "title"=>"Michael Jackson - Billie Jean", "times_played"=>3},
      {"youtube_id"=>"f-oC-kNtPTs", "title"=>"Great Big Sea - When I'm Up (I Can't Get Down)", "times_played"=>3},
      {"youtube_id"=>"NRWUoDpo2fo", "title"=>"alt-J - Left Hand Free (Official Video) 1", "times_played"=>3},
      {"youtube_id"=>"Eco4z98nIQY", "title"=>"Parov Stelar - Booty Swing", "times_played"=>3},
      {"youtube_id"=>"HjwYHIrA5PQ", "title"=>"Lana Del Rey vs Cedric Gervais - Young & Beautiful (Remix) [Official Music Video]", "times_played"=>3},
      {"youtube_id"=>"6teOmBuMxw4", "title"=>"Vance Joy - Riptide (FlicFlac Edit)", "times_played"=>3},
      {"youtube_id"=>"LWnP9r222DY", "title"=>"Crazy Town - Butterfly", "times_played"=>3},
      {"youtube_id"=>"rId6PKlDXeU", "title"=>"Mumford & Sons - Hopeless Wanderer", "times_played"=>3},
      {"youtube_id"=>"c_yengUrkaU", "title"=>"Half Moon Run - Call Me in the Afternoon [Official]", "times_played"=>3},
      {"youtube_id"=>"q7Bsb-8pxG8", "title"=>"The Night Pat Murphy Died - Great Big Sea", "times_played"=>3},
      {"youtube_id"=>"Hy-5d4r_6Y8", "title"=>"Usher - Yeah HD", "times_played"=>3},
      {"youtube_id"=>"iw-f5ehOvZk", "title"=>"Puscifer Tiny Monsters (with Lyrics)", "times_played"=>3},
      {"youtube_id"=>"uaojQC3X3TA", "title"=>"Save the World (Extended Mix) - Swedish House Mafia", "times_played"=>3},
      {"youtube_id"=>"x-64CaD8GXw", "title"=>"I'm Shipping Up To Boston - Dropkick Murphys", "times_played"=>3},
      {"youtube_id"=>"E1fzJ_AYajA", "title"=>"Len - Steal My Sunshine", "times_played"=>3},
      {"youtube_id"=>"GCdwKhTtNNw", "title"=>"The Neighbourhood - Sweater Weather", "times_played"=>3},
      {"youtube_id"=>"RQa7SvVCdZk", "title"=>"Christina Aguilera, Lil' Kim, Mya, Pink - Lady Marmalade", "times_played"=>3},
      {"youtube_id"=>"CPAnW56fQW4", "title"=>"Alesso & Calvin Harris feat. Hurts - Under Control (Extended Mix)", "times_played"=>3},
      {"youtube_id"=>"a5uQMwRMHcs", "title"=>"Daft Punk - Instant Crush ft. Julian Casablancas", "times_played"=>3},
      {"youtube_id"=>"ktvTqknDobU", "title"=>"Imagine Dragons - Radioactive", "times_played"=>3},
      {"youtube_id"=>"Eu5mEgmMy7U", "title"=>"Steve Aoki & Chris Lake & Tujamo - Boneless (Original Mix)", "times_played"=>3},
      {"youtube_id"=>"zVftCrKKY28", "title"=>"JULIAN TAYLOR BAND - 'Heatwave' (Official Audio)", "times_played"=>3},
      {"youtube_id"=>"6drfp_3823I", "title"=>"London Grammar - Strong (Official Video)", "times_played"=>3},
      {"youtube_id"=>"hiP14ED28CA", "title"=>"Jason Derulo - \"Wiggle\" feat. Snoop Dogg (Official HD Music Video)", "times_played"=>3},
      {"youtube_id"=>"hvKyBcCDOB4", "title"=>"Darius Rucker - Wagon Wheel", "times_played"=>3},
      {"youtube_id"=>"v39LdFLX038", "title"=>"Dirty Heads - \"My Sweet Summer\" (Lyric Video)", "times_played"=>3},
      {"youtube_id"=>"fFtGfyruroU", "title"=>"Edith Piaf - Non, je ne regrette rien - (original)", "times_played"=>3},
      {"youtube_id"=>"97ECZMvbLxg", "title"=>"one Bourbon one Scotch one Beer - George Thorogood", "times_played"=>3},
      {"youtube_id"=>"ff0oWESdmH0", "title"=>"The Killers - When You Were Young", "times_played"=>3},
      {"youtube_id"=>"AomiOTdyCqo", "title"=>"Milky Chance - Stolen Dance [OFFICIAL VIDEO] [HD]", "times_played"=>3},
      {"youtube_id"=>"cHcQiEqjtzs", "title"=>"Arkells - 11:11 (Lyric Video)", "times_played"=>2},
      {"youtube_id"=>"K0G9T5Bnjlc", "title"=>"Sam Smith - Money On My Mind", "times_played"=>2},
      {"youtube_id"=>"1y6smkh6c-0", "title"=>"Swedish House Mafia - Don't You Worry Child ft. John Martin", "times_played"=>2},
      {"youtube_id"=>"QK8mJJJvaes", "title"=>"MACKLEMORE & RYAN LEWIS - THRIFT SHOP FEAT. WANZ (OFFICIAL VIDEO)", "times_played"=>2},
      {"youtube_id"=>"xPYcbMADOt8", "title"=>"Sam Roberts Band - Shapeshifters", "times_played"=>2},
      {"youtube_id"=>"uSMN1ugJAos", "title"=>"The Sheepdogs - Feeling Good [Official Music Video]", "times_played"=>2},
      {"youtube_id"=>"gg7HvrA0Z7I", "title"=>"Arkells - Come To Light", "times_played"=>2},
      {"youtube_id"=>"f4hsC0nRvZM", "title"=>"John Denver - Leaving on a Jet Plane", "times_played"=>2},
      {"youtube_id"=>"MBqzrj18S2w", "title"=>"Foster The People - Coming of Age", "times_played"=>2},
      {"youtube_id"=>"ZI5Xpl7H5O4", "title"=>"The Lumineers - Flowers in your hair ( lyrics )", "times_played"=>2},
      {"youtube_id"=>"A2ZioQTekAk", "title"=>"Domeno - Titan (Original Mix) - OUT NOW", "times_played"=>2},
      {"youtube_id"=>"cqL6OQ9zQv8", "title"=>"James Brown - I feel good (Good Morning Vietnam Soundtrack) 1988", "times_played"=>2},
      {"youtube_id"=>"mCHUw7ACS8o", "title"=>"Of Monsters and Men - Dirty Paws (Official Lyric Video)", "times_played"=>2},
      {"youtube_id"=>"44HUh3q4gpI", "title"=>"Milky Chance - Stolen dance", "times_played"=>2},
      {"youtube_id"=>"h_27OOIDNdE", "title"=>"The Offspring - Spare Me The Details + Lyrics", "times_played"=>2},
      {"youtube_id"=>"7R1nRxcICeE", "title"=>"The Lego Movie - Everything Is Awesome | Movie Version | 10 Hours", "times_played"=>2},
      {"youtube_id"=>"nP6xBFyA_aw", "title"=>"David Bowie- Space Oddity (With Lyrics) HD", "times_played"=>2},
      {"youtube_id"=>"bg1sT4ILG0w", "title"=>"Nico & Vinz - Am I Wrong [Official Music Video]", "times_played"=>2},
      {"youtube_id"=>"Bj1AesMfIf8", "title"=>"Beatles- Here Comes The Sun (with lyrics)", "times_played"=>2},
      {"youtube_id"=>"XPbN2pQXe1o", "title"=>"Lana Del Rey - Summertime Sadness (Cedric Gervais Remix)", "times_played"=>2},
      {"youtube_id"=>"OOevVQwQ-LM", "title"=>"Alesso vs OneRepublic - If I Lose Myself (Alesso Remix)", "times_played"=>2},
      {"youtube_id"=>"a2RA0vsZXf8", "title"=>"\"Just A Dream\" by Nelly - Sam Tsui & Christina Grimmie", "times_played"=>2},
      {"youtube_id"=>"rf7GfUORHtw", "title"=>"Tim McGraw - Truck Yeah", "times_played"=>2},
      {"youtube_id"=>"g8v6cZ21vlc", "title"=>"Gloria Estefan~ Conga FULL HQ", "times_played"=>2},
      {"youtube_id"=>"hZV785_Ug9A", "title"=>"Milky Chance - Stolen Dance (Flic Flac Edit)", "times_played"=>2},
      {"youtube_id"=>"a3I7wBck0e4", "title"=>"Ricky Martin - Vida (Official)", "times_played"=>2},
      {"youtube_id"=>"fNy8llTLvuA", "title"=>"Mumford & Sons - The Cave", "times_played"=>2},
      {"youtube_id"=>"jjbl2eTkfPw", "title"=>"Mother Mother - Baby Don't Dance", "times_played"=>2},
      {"youtube_id"=>"LkLcnqYm5Uo", "title"=>"alt-J - Left Hand Free (Official Audio)", "times_played"=>2},
      {"youtube_id"=>"YxIiPLVR6NA", "title"=>"Avicii - Hey Brother (Lyric)", "times_played"=>2},
      {"youtube_id"=>"Nntd2fgMUYw", "title"=>"Eagle-Eye Cherry - Save Tonight", "times_played"=>2},
      {"youtube_id"=>"UPW8y6woTBI", "title"=>"Band Of Horses - The Funeral (2006)", "times_played"=>2},
      {"youtube_id"=>"dZLfasMPOU4", "title"=>"Fountains of Wayne - Stacy's Mom", "times_played"=>2},
      {"youtube_id"=>"fUyF6xfzHMA", "title"=>"Dada Life - So Young So High", "times_played"=>2},
      {"youtube_id"=>"9nT78Encur8", "title"=>"David Guetta | Ft. Afrojack | Louder Than Words | The Groove Cruise |", "times_played"=>2},
      {"youtube_id"=>"EntIUBtLj6A", "title"=>"Kiesza - Hideaway Lyrics", "times_played"=>2},
      {"youtube_id"=>"YS4fXhiVEQM", "title"=>"AWOLNATION - Sail (Unlimited Gravity Remix) (Audio)", "times_played"=>2},
      {"youtube_id"=>"WF34N4gJAKE", "title"=>"Bonobo : Cirrus [Official Video]", "times_played"=>2},
      {"youtube_id"=>"I_izvAbhExY", "title"=>"Bee Gees - Stayin' Alive (1977)", "times_played"=>2},
      {"youtube_id"=>"6366dxFf-Os", "title"=>"Why'd You Only Call Me When You're High? (Official Video)", "times_played"=>2},
      {"youtube_id"=>"YkyhvCdJ_vM", "title"=>"Sean Kingston - Fire Burning", "times_played"=>2},
      {"youtube_id"=>"cVBCE3gaNxc", "title"=>"[HD] Pink Floyd - The Great Gig In The Sky", "times_played"=>2},
      {"youtube_id"=>"MabuNr-wQkk", "title"=>"Oh, The Boss Is Coming - Arkells", "times_played"=>2},
      {"youtube_id"=>"Imixg3jrJS8", "title"=>"Ellie Goulding - Lights (Bassnectar Remix)", "times_played"=>2},
      {"youtube_id"=>"lDK9QqIzhwk", "title"=>"Bon Jovi - Livin' On A Prayer", "times_played"=>2},
      {"youtube_id"=>"gGdGFtwCNBE", "title"=>"The Killers - Mr. Brightside", "times_played"=>2},
      {"youtube_id"=>"VBmEJZofz2s", "title"=>"Nico & Vinz - Am I Wrong [Official Lyric Video]", "times_played"=>2},
      {"youtube_id"=>"BUfLJUPLIzg", "title"=>"Hey Rosetta! Performs \"Welcome\" Live at Chicago Music Exchange", "times_played"=>2},
      {"youtube_id"=>"m-M1AtrxztU", "title"=>"Clean Bandit - Rather Be (feat. Jess Glynne) (Official Video)", "times_played"=>2},
      {"youtube_id"=>"aXWj3RngKUc", "title"=>"Linkin Park feat. Jay-Z - Numb/Encore [HQ]", "times_played"=>2},
      {"youtube_id"=>"NsxcZol_FEE", "title"=>"Dropkick Murphys - I'm Shipping Up To Boston ..with lyrics", "times_played"=>2},
      {"youtube_id"=>"FgsgB8qGGKo", "title"=>"Non Stop Country Songs volume 1", "times_played"=>2},
      {"youtube_id"=>"ILQ3Hyl5xVA", "title"=>"Little Comets - The Blur, The Line and the Thickest of Onions", "times_played"=>2},
      {"youtube_id"=>"iqdXeHN6cZA", "title"=>"Lana Del Rey - Blue Jeans (RAC Remix)", "times_played"=>2},
      {"youtube_id"=>"1YXXAuBy2UQ", "title"=>"Lil Wayne-La La La", "times_played"=>2},
      {"youtube_id"=>"Gw7gNf_9njs", "title"=>"Dixie Chicks - Goodbye Earl", "times_played"=>2},
      {"youtube_id"=>"zp7NtW_hKJI", "title"=>"Coldplay - A Sky Full Of Stars (Official audio)", "times_played"=>2},
      {"youtube_id"=>"uJ_1HMAGb4k", "title"=>"Vance Joy - 'Riptide' Official Video", "times_played"=>2},
      {"youtube_id"=>"n6RTF4OPzf8", "title"=>"Daft Punk - One More Time [HQ]", "times_played"=>2},
      {"youtube_id"=>"azV0Y7v6wsg", "title"=>"Half Moon Run - Full Circle (Official Video)", "times_played"=>2},
      {"youtube_id"=>"3vPIEXhwYdE", "title"=>"Nicky Romero - Toulouse (Original Mix)", "times_played"=>2},
      {"youtube_id"=>"_JZom_gVfuw", "title"=>"The Notorious B.I.G. - \"Juicy\"", "times_played"=>2},
      {"youtube_id"=>"FGBhQbmPwH8", "title"=>"Daft Punk - One More Time", "times_played"=>2},
      {"youtube_id"=>"l5aZJBLAu1E", "title"=>"The Weather Girls - It's Raining Men", "times_played"=>2},
      {"youtube_id"=>"Zx1_6F-nCaw", "title"=>"A Little Less Conversation (Elvis vs JXL)", "times_played"=>2},
      {"youtube_id"=>"6Zbi0XmGtMw", "title"=>"Vengaboys - We like to Party! (The Vengabus)", "times_played"=>2},
      {"youtube_id"=>"js8Qg32sBjE", "title"=>"deadmau5 - The Veldt (featuring Chris James) (8 Minute Edit) (Cover Art)", "times_played"=>2},
      {"youtube_id"=>"YnwfTHpnGLY", "title"=>"deadmau5 - Raise Your Weapon", "times_played"=>2},
      {"youtube_id"=>"Whv1tLqKZig", "title"=>"HOLLERADO - AMERICANARAMA (OFFICIAL VIDEO)", "times_played"=>2},
      {"youtube_id"=>"BXWvKDSwvls", "title"=>"Joe Walsh - Life's Been Good", "times_played"=>2},
      {"youtube_id"=>"tJ33UR_Na9w", "title"=>"Run to you Eric Chase Remix", "times_played"=>2},
      {"youtube_id"=>"ZJL4UGSbeFg", "title"=>"Shania Twain - Man! I Feel Like A Woman", "times_played"=>2},
      {"youtube_id"=>"vEHC-fXhWbA", "title"=>"Ray LaMontagne - Airwaves (Audio)", "times_played"=>2},
      {"youtube_id"=>"CBsVRqaJJA4", "title"=>"Hardwell - Encoded (Official Music Video)", "times_played"=>2},
      {"youtube_id"=>"reTx5sqvVJ4", "title"=>"Sir Mix-A-Lot - Baby Got Back (I Like Big Butts) [ORIGINAL]", "times_played"=>2},
      {"youtube_id"=>"_My0kV5v_0M", "title"=>"Masta-ace -Take a walk (lyrics)", "times_played"=>2},
      {"youtube_id"=>"QZmM4YeSu8g", "title"=>"Red Hot Chili Peppers - Dani California (Lyrics)", "times_played"=>2},
      {"youtube_id"=>"0q10ICt_89I", "title"=>"Calvin Harris - Awooga (Original Mix)", "times_played"=>2},
      {"youtube_id"=>"IYH7_GzP4Tg", "title"=>"Lil Jon & The East Side Boyz - Get Low (Official Music Video)", "times_played"=>2},
      {"youtube_id"=>"vqtLq6B75fI", "title"=>"Ben Gold - Amplified (Original Mix) [Full Tune]", "times_played"=>2},
      {"youtube_id"=>"hdH8q0yHpRM", "title"=>"Paul Oakenfold Starry Eyed Surprise [WITH LYRICS]", "times_played"=>2},
      {"youtube_id"=>"CFF0mV24WCY", "title"=>"Tiësto - Red Lights", "times_played"=>2},
      {"youtube_id"=>"yRDivUb5EeA", "title"=>"The Allman Brothers Band - Jessica", "times_played"=>2},
      {"youtube_id"=>"Jbp52Z9jRg0", "title"=>"mulan -  I'll make a man out of you lyrics", "times_played"=>2},
      {"youtube_id"=>"bmXumtgwtak", "title"=>"Eminem - Lose Yourself (Official Music Video)", "times_played"=>2},
      {"youtube_id"=>"0UIB9Y4OFPs", "title"=>"DEF LEPPARD - \"Pour Some Sugar On Me\" (Official Music Video)", "times_played"=>2},
      {"youtube_id"=>"xhrBDcQq2DM", "title"=>"Haddaway - What Is Love", "times_played"=>2},
      {"youtube_id"=>"S7dcA_N6EmQ", "title"=>"Krewella - Alive (Acoustic Version)", "times_played"=>2},
      {"youtube_id"=>"fJ9rUzIMcZQ", "title"=>"Queen - Bohemian Rhapsody (Official Video)", "times_played"=>2},
      {"youtube_id"=>"zKOwq9dAMyY", "title"=>"50 Cent - P.I.M.P. (Snoop Dogg Remix) ft. Snoop Dogg, G-Unit", "times_played"=>2},
      {"youtube_id"=>"np0solnL1XY", "title"=>"Lynyrd Skynyrd-Free bird", "times_played"=>2},
      {"youtube_id"=>"l8CUJkIwARs", "title"=>"Waiting for the Night (Lyrics) - Armin van Buuren Feat. Fiora", "times_played"=>2},
      {"youtube_id"=>"gtATrfNQJLU", "title"=>"A Tribe Called Quest - Can I Kick It", "times_played"=>2},
      {"youtube_id"=>"_9syE2UP11E", "title"=>"John Legend - All Of Me (Tiësto Remix)", "times_played"=>2},
      {"youtube_id"=>"UG9I752Mmdk", "title"=>"The Sound of Music Soundtrack - 12 - So Long, Farewell", "times_played"=>2},
      {"youtube_id"=>"GZ8Pkqd0ct4", "title"=>"Milky Chance Stolen Dance LYRICS", "times_played"=>2}
    ]
  def up
    return unless ENV['RAILS_ENV'] == 'production'

    confederation = Room.find(4)
    DATA_TO_IMPORT.each do |video_params|
      video = Video.create_with(title: video_params["title"]).find_or_create_by(youtube_id: video_params["youtube_id"])
      video_params["times_played"].times { video.play_in(confederation) }
    end
  end
end