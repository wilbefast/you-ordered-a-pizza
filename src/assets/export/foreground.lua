local f = {width=8192,height=2048,image=love.graphics.newImage('assets/export/foreground.png')}
f.batch=love.graphics.newSpriteBatch(f.image, 1000)
f.pieces = {}
f.pieces['arm_Charlie']={img=f.image,quad=love.graphics.newQuad(1751,1685,24,100,8192,2048),x=1751,y=1685,w=24,h=100}
f.pieces['arm_Ours']={img=f.image,quad=love.graphics.newQuad(7100,1675,60,124,8192,2048),x=7100,y=1675,w=60,h=124}
f.pieces['head_Ours2']={img=f.image,quad=love.graphics.newQuad(2377,1536,200,200,8192,2048),x=2377,y=1536,w=200,h=200}
f.pieces['head_RoundEye']={img=f.image,quad=love.graphics.newQuad(1337,1685,138,138,8192,2048),x=1337,y=1685,w=138,h=138}
f.pieces['rightArm_Shirt02']={img=f.image,quad=love.graphics.newQuad(694,1892,33,89,8192,2048),x=694,y=1892,w=33,h=89}
f.pieces['leftHand_Vador']={img=f.image,quad=love.graphics.newQuad(2231,1884,59,72,8192,2048),x=2231,y=1884,w=59,h=72}
f.pieces['arm_1']={img=f.image,quad=love.graphics.newQuad(8180,1714,12,89,8192,2048),x=8180,y=1714,w=12,h=89}
f.pieces['stickers_orgy']={img=f.image,quad=love.graphics.newQuad(5469,1780,89,88,8192,2048),x=5469,y=1780,w=89,h=88}
f.pieces['groinSlip_Vador']={img=f.image,quad=love.graphics.newQuad(4490,1873,81,53,8192,2048),x=4490,y=1873,w=81,h=53}
f.pieces['stickers_hippie']={img=f.image,quad=love.graphics.newQuad(7809,1854,75,73,8192,2048),x=7809,y=1854,w=75,h=73}
f.pieces['casier']={img=f.image,quad=love.graphics.newQuad(5996,1536,157,178,8192,2048),x=5996,y=1536,w=157,h=178}
f.pieces['torso_Ours']={img=f.image,quad=love.graphics.newQuad(5358,1780,111,148,8192,2048),x=5358,y=1780,w=111,h=148}
f.pieces['rightForeArm_Shirt03']={img=f.image,quad=love.graphics.newQuad(5208,1860,33,93,8192,2048),x=5208,y=1860,w=33,h=93}
f.pieces['leftFoot_Vador']={img=f.image,quad=love.graphics.newQuad(5564,1536,108,268,8192,2048),x=5564,y=1536,w=108,h=268}
f.pieces['light']={img=f.image,quad=love.graphics.newQuad(7168,0,1024,768,8192,2048),x=7168,y=0,w=1024,h=768}
f.pieces['head_Vador2']={img=f.image,quad=love.graphics.newQuad(1777,1536,200,200,8192,2048),x=1777,y=1536,w=200,h=200}
f.pieces['rightFoot_Burka']={img=f.image,quad=love.graphics.newQuad(1583,1823,110,75,8192,2048),x=1583,y=1823,w=110,h=75}
f.pieces['torso_Burka']={img=f.image,quad=love.graphics.newQuad(5097,1536,150,200,8192,2048),x=5097,y=1536,w=150,h=200}
f.pieces['arm_2']={img=f.image,quad=love.graphics.newQuad(8180,1536,12,89,8192,2048),x=8180,y=1536,w=12,h=89}
f.pieces['head_AsiatEye']={img=f.image,quad=love.graphics.newQuad(1199,1685,138,138,8192,2048),x=1199,y=1685,w=138,h=138}
f.pieces['leftForeArm_Shirt01']={img=f.image,quad=love.graphics.newQuad(8138,1887,33,93,8192,2048),x=8138,y=1887,w=33,h=93}
f.pieces['groin_2']={img=f.image,quad=love.graphics.newQuad(1481,1898,53,53,8192,2048),x=1481,y=1898,w=53,h=53}
f.pieces['leg_3']={img=f.image,quad=love.graphics.newQuad(5547,1630,16,120,8192,2048),x=5547,y=1630,w=16,h=120}
f.pieces['torso_2']={img=f.image,quad=love.graphics.newQuad(2543,1736,111,148,8192,2048),x=2543,y=1736,w=111,h=148}
f.pieces['head_pape']={img=f.image,quad=love.graphics.newQuad(3797,1536,138,250,8192,2048),x=3797,y=1536,w=138,h=250}
f.pieces['groinW_2']={img=f.image,quad=love.graphics.newQuad(5469,1868,81,53,8192,2048),x=5469,y=1868,w=81,h=53}
f.pieces['rightArm_Dalai']={img=f.image,quad=love.graphics.newQuad(628,1892,33,89,8192,2048),x=628,y=1892,w=33,h=89}
f.pieces['groin_Robot']={img=f.image,quad=love.graphics.newQuad(2876,1736,100,100,8192,2048),x=2876,y=1736,w=100,h=100}
f.pieces['leg_Ours']={img=f.image,quad=love.graphics.newQuad(7721,1689,60,124,8192,2048),x=7721,y=1689,w=60,h=124}
f.pieces['leg_2']={img=f.image,quad=love.graphics.newQuad(6136,1714,16,120,8192,2048),x=6136,y=1714,w=16,h=120}
f.pieces['groin_Charlie2']={img=f.image,quad=love.graphics.newQuad(4807,1536,112,300,8192,2048),x=4807,y=1536,w=112,h=300}
f.pieces['groinW_1']={img=f.image,quad=love.graphics.newQuad(6636,1879,81,53,8192,2048),x=6636,y=1879,w=81,h=53}
f.pieces['leg_Vador']={img=f.image,quad=love.graphics.newQuad(4595,1786,29,124,8192,2048),x=4595,y=1786,w=29,h=124}
f.pieces['Charlie']={img=f.image,quad=love.graphics.newQuad(6989,1675,111,200,8192,2048),x=6989,y=1675,w=111,h=200}
f.pieces['leftFoot_Burka']={img=f.image,quad=love.graphics.newQuad(7279,1827,110,75,8192,2048),x=7279,y=1827,w=110,h=75}
f.pieces['Objet_Sabre']={img=f.image,quad=love.graphics.newQuad(5564,1804,331,40,8192,2048),x=5564,y=1804,w=331,h=40}
f.pieces['torso_Bra_01']={img=f.image,quad=love.graphics.newQuad(1877,1736,111,148,8192,2048),x=1877,y=1736,w=111,h=148}
f.pieces['window_Clean']={img=f.image,quad=love.graphics.newQuad(1119,1536,329,149,8192,2048),x=1119,y=1536,w=329,h=149}
f.pieces['Objet_LAN3']={img=f.image,quad=love.graphics.newQuad(3147,1536,175,204,8192,2048),x=3147,y=1536,w=175,h=204}
f.pieces['groin_Ours2']={img=f.image,quad=love.graphics.newQuad(1269,1898,53,53,8192,2048),x=1269,y=1898,w=53,h=53}
f.pieces['groin_Ours']={img=f.image,quad=love.graphics.newQuad(1216,1898,53,53,8192,2048),x=1216,y=1898,w=53,h=53}
f.pieces['rightArm_Rabbin']={img=f.image,quad=love.graphics.newQuad(6807,1888,33,89,8192,2048),x=6807,y=1888,w=33,h=89}
f.pieces['groin_Slip']={img=f.image,quad=love.graphics.newQuad(1109,1898,54,53,8192,2048),x=1109,y=1898,w=54,h=53}
f.pieces['left_foot_1']={img=f.image,quad=love.graphics.newQuad(790,1833,80,80,8192,2048),x=790,y=1833,w=80,h=80}
f.pieces['Objet_Robot1']={img=f.image,quad=love.graphics.newQuad(2977,1536,170,219,8192,2048),x=2977,y=1536,w=170,h=219}
f.pieces['groinPoil_Black']={img=f.image,quad=love.graphics.newQuad(6989,1875,81,53,8192,2048),x=6989,y=1875,w=81,h=53}
f.pieces['stickers_champagne']={img=f.image,quad=love.graphics.newQuad(6305,1656,150,150,8192,2048),x=6305,y=1656,w=150,h=150}
f.pieces['leftHand_1']={img=f.image,quad=love.graphics.newQuad(7659,1827,59,72,8192,2048),x=7659,y=1827,w=59,h=72}
f.pieces['torsoW_3']={img=f.image,quad=love.graphics.newQuad(3521,1786,111,148,8192,2048),x=3521,y=1786,w=111,h=148}
f.pieces['leftArm_Dalai']={img=f.image,quad=love.graphics.newQuad(1022,1898,33,89,8192,2048),x=1022,y=1898,w=33,h=89}
f.pieces['leftArm_Liberty']={img=f.image,quad=love.graphics.newQuad(989,1898,33,89,8192,2048),x=989,y=1898,w=33,h=89}
f.pieces['rightArm_Vador']={img=f.image,quad=love.graphics.newQuad(956,1898,33,89,8192,2048),x=956,y=1898,w=33,h=89}
f.pieces['arm_Burka']={img=f.image,quad=love.graphics.newQuad(923,1898,33,89,8192,2048),x=923,y=1898,w=33,h=89}
f.pieces['leftHand_Charlie']={img=f.image,quad=love.graphics.newQuad(5719,1844,70,80,8192,2048),x=5719,y=1844,w=70,h=80}
f.pieces['leftArm_Shirt03']={img=f.image,quad=love.graphics.newQuad(4735,1895,33,89,8192,2048),x=4735,y=1895,w=33,h=89}
f.pieces['left_foot_3']={img=f.image,quad=love.graphics.newQuad(6076,1837,80,80,8192,2048),x=6076,y=1837,w=80,h=80}
f.pieces['rightFoot_6']={img=f.image,quad=love.graphics.newQuad(5780,1536,108,268,8192,2048),x=5780,y=1536,w=108,h=268}
f.pieces['leftArm_Rabbin']={img=f.image,quad=love.graphics.newQuad(3088,1895,33,89,8192,2048),x=3088,y=1895,w=33,h=89}
f.pieces['leftArm_Vador']={img=f.image,quad=love.graphics.newQuad(7754,1894,33,89,8192,2048),x=7754,y=1894,w=33,h=89}
f.pieces['Objet_Cowboy']={img=f.image,quad=love.graphics.newQuad(3322,1536,199,175,8192,2048),x=3322,y=1536,w=199,h=175}
f.pieces['groin_Jeans']={img=f.image,quad=love.graphics.newQuad(5789,1844,67,83,8192,2048),x=5789,y=1844,w=67,h=83}
f.pieces['leftArm_Shirt04']={img=f.image,quad=love.graphics.newQuad(7721,1894,33,89,8192,2048),x=7721,y=1894,w=33,h=89}
f.pieces['rightArm_Shirt03']={img=f.image,quad=love.graphics.newQuad(4768,1895,33,89,8192,2048),x=4768,y=1895,w=33,h=89}
f.pieces['left_foot_Ours2']={img=f.image,quad=love.graphics.newQuad(7499,1827,80,80,8192,2048),x=7499,y=1827,w=80,h=80}
f.pieces['rightArm_pape']={img=f.image,quad=love.graphics.newQuad(661,1892,33,89,8192,2048),x=661,y=1892,w=33,h=89}
f.pieces['torso_3']={img=f.image,quad=love.graphics.newQuad(4076,1786,111,148,8192,2048),x=4076,y=1786,w=111,h=148}
f.pieces['rightFoot_5']={img=f.image,quad=love.graphics.newQuad(6525,1536,108,240,8192,2048),x=6525,y=1536,w=108,h=240}
f.pieces['rightArm_Shirt05']={img=f.image,quad=love.graphics.newQuad(4691,1890,33,89,8192,2048),x=4691,y=1890,w=33,h=89}
f.pieces['rightArm_Liberty']={img=f.image,quad=love.graphics.newQuad(4658,1890,33,89,8192,2048),x=4658,y=1890,w=33,h=89}
f.pieces['leftArm_Shirt01']={img=f.image,quad=love.graphics.newQuad(4625,1890,33,89,8192,2048),x=4625,y=1890,w=33,h=89}
f.pieces['torsoW_2']={img=f.image,quad=love.graphics.newQuad(2765,1736,111,148,8192,2048),x=2765,y=1736,w=111,h=148}
f.pieces['stickers_gamer']={img=f.image,quad=love.graphics.newQuad(5642,1844,77,76,8192,2048),x=5642,y=1844,w=77,h=76}
f.pieces['torso_Dalai']={img=f.image,quad=love.graphics.newQuad(3147,1740,111,148,8192,2048),x=3147,y=1740,w=111,h=148}
f.pieces['groin_pape']={img=f.image,quad=love.graphics.newQuad(628,1536,162,356,8192,2048),x=628,y=1536,w=162,h=356}
f.pieces['Objet_Indien']={img=f.image,quad=love.graphics.newQuad(6153,1536,152,180,8192,2048),x=6153,y=1536,w=152,h=180}
f.pieces['groin_Jupe04']={img=f.image,quad=love.graphics.newQuad(7649,1536,160,153,8192,2048),x=7649,y=1536,w=160,h=153}
f.pieces['window_Broken']={img=f.image,quad=love.graphics.newQuad(790,1536,329,149,8192,2048),x=790,y=1536,w=329,h=149}
f.pieces['rightHand_1']={img=f.image,quad=love.graphics.newQuad(7100,1882,59,72,8192,2048),x=7100,y=1882,w=59,h=72}
f.pieces['rightFoot_7']={img=f.image,quad=love.graphics.newQuad(923,1823,110,75,8192,2048),x=923,y=1823,w=110,h=75}
f.pieces['Objet_Dildo3']={img=f.image,quad=love.graphics.newQuad(6305,1536,220,120,8192,2048),x=6305,y=1536,w=220,h=120}
f.pieces['leftArm_pape']={img=f.image,quad=love.graphics.newQuad(6840,1888,33,89,8192,2048),x=6840,y=1888,w=33,h=89}
f.pieces['torso_Rabbin']={img=f.image,quad=love.graphics.newQuad(2321,1736,111,148,8192,2048),x=2321,y=1736,w=111,h=148}
f.pieces['groin_Terro']={img=f.image,quad=love.graphics.newQuad(1163,1898,53,53,8192,2048),x=1163,y=1898,w=53,h=53}
f.pieces['head_hat_Terro']={img=f.image,quad=love.graphics.newQuad(4211,1536,138,250,8192,2048),x=4211,y=1536,w=138,h=250}
f.pieces['stickers_normal']={img=f.image,quad=love.graphics.newQuad(2408,1884,65,64,8192,2048),x=2408,y=1884,w=65,h=64}
f.pieces['head_hat_Rabbin']={img=f.image,quad=love.graphics.newQuad(4073,1536,138,250,8192,2048),x=4073,y=1536,w=138,h=250}
f.pieces['rightArm_Shirt01']={img=f.image,quad=love.graphics.newQuad(6774,1888,33,89,8192,2048),x=6774,y=1888,w=33,h=89}
f.pieces['rightForeArm_Shirt04']={img=f.image,quad=love.graphics.newQuad(5059,1715,33,93,8192,2048),x=5059,y=1715,w=33,h=93}
f.pieces['torso_pape']={img=f.image,quad=love.graphics.newQuad(3743,1786,111,148,8192,2048),x=3743,y=1786,w=111,h=148}
f.pieces['torso_Bra_Dalai']={img=f.image,quad=love.graphics.newQuad(1988,1736,111,148,8192,2048),x=1988,y=1736,w=111,h=148}
f.pieces['rightForeArm_Shirt02']={img=f.image,quad=love.graphics.newQuad(5163,1884,33,93,8192,2048),x=5163,y=1884,w=33,h=93}
f.pieces['leftArm_Shirt02']={img=f.image,quad=love.graphics.newQuad(3213,1888,33,89,8192,2048),x=3213,y=1888,w=33,h=89}
f.pieces['bg']={img=f.image,quad=love.graphics.newQuad(6144,768,1024,768,8192,2048),x=6144,y=768,w=1024,h=768}
f.pieces['leg_Jeans']={img=f.image,quad=love.graphics.newQuad(870,1833,29,124,8192,2048),x=870,y=1833,w=29,h=124}
f.pieces['Objet_Motard']={img=f.image,quad=love.graphics.newQuad(3322,1711,140,123,8192,2048),x=3322,y=1711,w=140,h=123}
f.pieces['leftForeArm_Shirt02']={img=f.image,quad=love.graphics.newQuad(3180,1888,33,93,8192,2048),x=3180,y=1888,w=33,h=93}
f.pieces['torso_Liberty']={img=f.image,quad=love.graphics.newQuad(6525,1776,111,148,8192,2048),x=6525,y=1776,w=111,h=148}
f.pieces['Objet_LAN1']={img=f.image,quad=love.graphics.newQuad(4625,1722,181,93,8192,2048),x=4625,y=1722,w=181,h=93}
f.pieces['groin_Jupe05']={img=f.image,quad=love.graphics.newQuad(7489,1536,160,153,8192,2048),x=7489,y=1536,w=160,h=153}
f.pieces['leg_1']={img=f.image,quad=love.graphics.newQuad(3298,1740,16,120,8192,2048),x=3298,y=1740,w=16,h=120}
f.pieces['leftForeArm_Dalai']={img=f.image,quad=love.graphics.newQuad(8105,1887,33,93,8192,2048),x=8105,y=1887,w=33,h=93}
f.pieces['Objet_Explosif']={img=f.image,quad=love.graphics.newQuad(370,1794,177,70,8192,2048),x=370,y=1794,w=177,h=70}
f.pieces['rightForeArm_Shirt01']={img=f.image,quad=love.graphics.newQuad(8072,1887,33,93,8192,2048),x=8072,y=1887,w=33,h=93}
f.pieces['rightArm_Shirt04']={img=f.image,quad=love.graphics.newQuad(6741,1888,33,89,8192,2048),x=6741,y=1888,w=33,h=89}
f.pieces['rightForeArm_Liberty']={img=f.image,quad=love.graphics.newQuad(5130,1884,33,93,8192,2048),x=5130,y=1884,w=33,h=93}
f.pieces['torso_Bra_03']={img=f.image,quad=love.graphics.newQuad(2977,1755,111,148,8192,2048),x=2977,y=1755,w=111,h=148}
f.pieces['head_Rabbin']={img=f.image,quad=love.graphics.newQuad(370,1536,258,258,8192,2048),x=370,y=1536,w=258,h=258}
f.pieces['rightHand_2']={img=f.image,quad=love.graphics.newQuad(2054,1884,59,72,8192,2048),x=2054,y=1884,w=59,h=72}
f.pieces['stickers_robot']={img=f.image,quad=love.graphics.newQuad(5895,1804,94,76,8192,2048),x=5895,y=1804,w=94,h=76}
f.pieces['rightForeArm_Shirt05']={img=f.image,quad=love.graphics.newQuad(2692,1884,33,93,8192,2048),x=2692,y=1884,w=33,h=93}
f.pieces['doorOpen']={img=f.image,quad=love.graphics.newQuad(6144,0,1024,768,8192,2048),x=6144,y=0,w=1024,h=768}
f.pieces['leftHand_Ours2']={img=f.image,quad=love.graphics.newQuad(1936,1884,59,72,8192,2048),x=1936,y=1884,w=59,h=72}
f.pieces['leftForeArm_Shirt04']={img=f.image,quad=love.graphics.newQuad(2824,1884,33,93,8192,2048),x=2824,y=1884,w=33,h=93}
f.pieces['eyelash_Asiat']={img=f.image,quad=love.graphics.newQuad(1061,1685,138,138,8192,2048),x=1061,y=1685,w=138,h=138}
f.pieces['leftForeArm_Shirt05']={img=f.image,quad=love.graphics.newQuad(2593,1884,33,93,8192,2048),x=2593,y=1884,w=33,h=93}
f.pieces['leftForeArm_pape']={img=f.image,quad=love.graphics.newQuad(2758,1884,33,93,8192,2048),x=2758,y=1884,w=33,h=93}
f.pieces['Objet_Dildo1']={img=f.image,quad=love.graphics.newQuad(7721,1813,84,81,8192,2048),x=7721,y=1813,w=84,h=81}
f.pieces['Objet_Casque']={img=f.image,quad=love.graphics.newQuad(4919,1715,140,123,8192,2048),x=4919,y=1715,w=140,h=123}
f.pieces['leftFoot_3']={img=f.image,quad=love.graphics.newQuad(1253,1823,110,75,8192,2048),x=1253,y=1823,w=110,h=75}
f.pieces['head_Charlie']={img=f.image,quad=love.graphics.newQuad(2177,1536,200,200,8192,2048),x=2177,y=1536,w=200,h=200}
f.pieces['groin_Charlie']={img=f.image,quad=love.graphics.newQuad(1322,1898,53,53,8192,2048),x=1322,y=1898,w=53,h=53}
f.pieces['leftForeArm_Liberty']={img=f.image,quad=love.graphics.newQuad(2626,1884,33,93,8192,2048),x=2626,y=1884,w=33,h=93}
f.pieces['rightForeArm_Dalai']={img=f.image,quad=love.graphics.newQuad(2725,1884,33,93,8192,2048),x=2725,y=1884,w=33,h=93}
f.pieces['leftForeArm_Vador']={img=f.image,quad=love.graphics.newQuad(5856,1844,33,93,8192,2048),x=5856,y=1844,w=33,h=93}
f.pieces['leg_Robot']={img=f.image,quad=love.graphics.newQuad(3482,1834,29,124,8192,2048),x=3482,y=1834,w=29,h=124}
f.pieces['torso_Charlie2']={img=f.image,quad=love.graphics.newQuad(7809,1536,160,148,8192,2048),x=7809,y=1536,w=160,h=148}
f.pieces['rightHand_Vador']={img=f.image,quad=love.graphics.newQuad(2290,1884,59,72,8192,2048),x=2290,y=1884,w=59,h=72}
f.pieces['Objet_LAN2']={img=f.image,quad=love.graphics.newQuad(6989,1536,180,139,8192,2048),x=6989,y=1536,w=180,h=139}
f.pieces['leg_Rabbin']={img=f.image,quad=love.graphics.newQuad(5208,1736,29,124,8192,2048),x=5208,y=1736,w=29,h=124}
f.pieces['check']={img=f.image,quad=love.graphics.newQuad(5397,1630,150,150,8192,2048),x=5397,y=1630,w=150,h=150}
f.pieces['leftFoot_5']={img=f.image,quad=love.graphics.newQuad(6633,1536,108,240,8192,2048),x=6633,y=1536,w=108,h=240}
f.pieces['groinPoil_Blond']={img=f.image,quad=love.graphics.newQuad(6891,1871,81,53,8192,2048),x=6891,y=1871,w=81,h=53}
f.pieces['head_Brown_Hair']={img=f.image,quad=love.graphics.newQuad(7583,1689,138,138,8192,2048),x=7583,y=1689,w=138,h=138}
f.pieces['torso_Shirt02']={img=f.image,quad=love.graphics.newQuad(2654,1736,111,148,8192,2048),x=2654,y=1736,w=111,h=148}
f.pieces['rightFoot_3']={img=f.image,quad=love.graphics.newQuad(4625,1815,110,75,8192,2048),x=4625,y=1815,w=110,h=75}
f.pieces['cursor_up']={img=f.image,quad=love.graphics.newQuad(2533,1884,60,60,8192,2048),x=2533,y=1884,w=60,h=60}
f.pieces['Objet_pizza']={img=f.image,quad=love.graphics.newQuad(4919,1536,178,179,8192,2048),x=4919,y=1536,w=178,h=179}
f.pieces['Objet_AK47']={img=f.image,quad=love.graphics.newQuad(5247,1536,317,94,8192,2048),x=5247,y=1536,w=317,h=94}
f.pieces['rightFoot_1']={img=f.image,quad=love.graphics.newQuad(7389,1827,110,75,8192,2048),x=7389,y=1827,w=110,h=75}
f.pieces['torso_Ours2']={img=f.image,quad=love.graphics.newQuad(2210,1736,111,148,8192,2048),x=2210,y=1736,w=111,h=148}
f.pieces['leftFoot_4']={img=f.image,quad=love.graphics.newQuad(1033,1823,110,75,8192,2048),x=1033,y=1823,w=110,h=75}
f.pieces['head_Dalai']={img=f.image,quad=love.graphics.newQuad(6305,1806,103,103,8192,2048),x=6305,y=1806,w=103,h=103}
f.pieces['rightHand_Robot']={img=f.image,quad=love.graphics.newQuad(2349,1884,59,72,8192,2048),x=2349,y=1884,w=59,h=72}
f.pieces['rightHand_Ours']={img=f.image,quad=love.graphics.newQuad(2172,1884,59,72,8192,2048),x=2172,y=1884,w=59,h=72}
f.pieces['Culotte_1']={img=f.image,quad=love.graphics.newQuad(7884,1854,70,70,8192,2048),x=7884,y=1854,w=70,h=70}
f.pieces['leftHand_2']={img=f.image,quad=love.graphics.newQuad(3258,1880,59,72,8192,2048),x=3258,y=1880,w=59,h=72}
f.pieces['dingdong']={img=f.image,quad=love.graphics.newQuad(7969,1536,182,126,8192,2048),x=7969,y=1536,w=182,h=126}
f.pieces['torso_Bra_02']={img=f.image,quad=love.graphics.newQuad(2099,1736,111,148,8192,2048),x=2099,y=1736,w=111,h=148}
f.pieces['Objet_Police']={img=f.image,quad=love.graphics.newQuad(5996,1714,140,123,8192,2048),x=5996,y=1714,w=140,h=123}
f.pieces['torso_Charlie']={img=f.image,quad=love.graphics.newQuad(7809,1684,130,170,8192,2048),x=7809,y=1684,w=130,h=170}
f.pieces['groin_Dalai2']={img=f.image,quad=love.graphics.newQuad(185,1536,185,500,8192,2048),x=185,y=1536,w=185,h=500}
f.pieces['leftFoot_1']={img=f.image,quad=love.graphics.newQuad(7169,1827,110,75,8192,2048),x=7169,y=1827,w=110,h=75}
f.pieces['leftHand_3']={img=f.image,quad=love.graphics.newQuad(2113,1884,59,72,8192,2048),x=2113,y=1884,w=59,h=72}
f.pieces['right_foot_Robot']={img=f.image,quad=love.graphics.newQuad(5996,1837,80,80,8192,2048),x=5996,y=1837,w=80,h=80}
f.pieces['rightHand_Ours2']={img=f.image,quad=love.graphics.newQuad(1995,1884,59,72,8192,2048),x=1995,y=1884,w=59,h=72}
f.pieces['rightHand_3']={img=f.image,quad=love.graphics.newQuad(1877,1884,59,72,8192,2048),x=1877,y=1884,w=59,h=72}
f.pieces['leftHand_Ours']={img=f.image,quad=love.graphics.newQuad(5895,1880,59,72,8192,2048),x=5895,y=1880,w=59,h=72}
f.pieces['right_foot_3']={img=f.image,quad=love.graphics.newQuad(547,1794,80,80,8192,2048),x=547,y=1794,w=80,h=80}
f.pieces['leftHand_Robot']={img=f.image,quad=love.graphics.newQuad(3462,1711,59,72,8192,2048),x=3462,y=1711,w=59,h=72}
f.pieces['rightFoot_Vador']={img=f.image,quad=love.graphics.newQuad(5672,1536,108,268,8192,2048),x=5672,y=1536,w=108,h=268}
f.pieces['groinW_3']={img=f.image,quad=love.graphics.newQuad(547,1874,81,53,8192,2048),x=547,y=1874,w=81,h=53}
f.pieces['right_foot_Ours']={img=f.image,quad=love.graphics.newQuad(4807,1836,80,80,8192,2048),x=4807,y=1836,w=80,h=80}
f.pieces['lipstick_Red']={img=f.image,quad=love.graphics.newQuad(7445,1689,138,138,8192,2048),x=7445,y=1689,w=138,h=138}
f.pieces['Objet_LAN4']={img=f.image,quad=love.graphics.newQuad(1777,1736,100,168,8192,2048),x=1777,y=1736,w=100,h=168}
f.pieces['groinPoil_Brown']={img=f.image,quad=love.graphics.newQuad(445,1864,81,53,8192,2048),x=445,y=1864,w=81,h=53}
f.pieces['Objet_Champagne']={img=f.image,quad=love.graphics.newQuad(6891,1638,94,233,8192,2048),x=6891,y=1638,w=94,h=233}
f.pieces['groin_Rabbin']={img=f.image,quad=love.graphics.newQuad(6236,1837,67,83,8192,2048),x=6236,y=1837,w=67,h=83}
f.pieces['groin_Vador']={img=f.image,quad=love.graphics.newQuad(7100,1799,67,83,8192,2048),x=7100,y=1799,w=67,h=83}
f.pieces['leftArm_Shirt05']={img=f.image,quad=love.graphics.newQuad(727,1892,33,89,8192,2048),x=727,y=1892,w=33,h=89}
f.pieces['rightHand_Charlie']={img=f.image,quad=love.graphics.newQuad(4735,1815,70,80,8192,2048),x=4735,y=1815,w=70,h=80}
f.pieces['head_Robot_3']={img=f.image,quad=love.graphics.newQuad(6741,1638,150,150,8192,2048),x=6741,y=1638,w=150,h=150}
f.pieces['head_Long_Red_Hair']={img=f.image,quad=love.graphics.newQuad(4487,1536,138,250,8192,2048),x=4487,y=1536,w=138,h=250}
f.pieces['leg_Charlie2']={img=f.image,quad=love.graphics.newQuad(3088,1755,40,140,8192,2048),x=3088,y=1755,w=40,h=140}
f.pieces['head_Black_Hair']={img=f.image,quad=love.graphics.newQuad(7169,1689,138,138,8192,2048),x=7169,y=1689,w=138,h=138}
f.pieces['leg_Charlie']={img=f.image,quad=love.graphics.newQuad(3258,1740,40,140,8192,2048),x=3258,y=1740,w=40,h=140}
f.pieces['bgFin']={img=f.image,quad=love.graphics.newQuad(0,0,6144,1536,8192,2048),x=0,y=0,w=6144,h=1536}
f.pieces['stickers_alone']={img=f.image,quad=love.graphics.newQuad(5564,1844,78,78,8192,2048),x=5564,y=1844,w=78,h=78}
f.pieces['eyelash_1']={img=f.image,quad=love.graphics.newQuad(923,1685,138,138,8192,2048),x=923,y=1685,w=138,h=138}
f.pieces['window_BrokenCat']={img=f.image,quad=love.graphics.newQuad(1448,1536,329,149,8192,2048),x=1448,y=1536,w=329,h=149}
f.pieces['head_Red_Hair']={img=f.image,quad=love.graphics.newQuad(1613,1685,138,138,8192,2048),x=1613,y=1685,w=138,h=138}
f.pieces['right_foot_2']={img=f.image,quad=love.graphics.newQuad(4999,1838,80,80,8192,2048),x=4999,y=1838,w=80,h=80}
f.pieces['head_1']={img=f.image,quad=love.graphics.newQuad(7969,1812,103,103,8192,2048),x=7969,y=1812,w=103,h=103}
f.pieces['left_foot_Robot']={img=f.image,quad=love.graphics.newQuad(4919,1838,80,80,8192,2048),x=4919,y=1838,w=80,h=80}
f.pieces['torso_Shirt05']={img=f.image,quad=love.graphics.newQuad(4187,1786,111,148,8192,2048),x=4187,y=1786,w=111,h=148}
f.pieces['head_Long_Blond_Hair']={img=f.image,quad=love.graphics.newQuad(3659,1536,138,250,8192,2048),x=3659,y=1536,w=138,h=250}
f.pieces['groinPoil_Red']={img=f.image,quad=love.graphics.newQuad(4409,1873,81,53,8192,2048),x=4409,y=1873,w=81,h=53}
f.pieces['right_foot_1']={img=f.image,quad=love.graphics.newQuad(2876,1836,80,80,8192,2048),x=2876,y=1836,w=80,h=80}
f.pieces['right_foot_Charlie']={img=f.image,quad=love.graphics.newQuad(3402,1834,80,80,8192,2048),x=3402,y=1834,w=80,h=80}
f.pieces['left_foot_2']={img=f.image,quad=love.graphics.newQuad(3322,1834,80,80,8192,2048),x=3322,y=1834,w=80,h=80}
f.pieces['leftFoot_2']={img=f.image,quad=love.graphics.newQuad(1363,1823,110,75,8192,2048),x=1363,y=1823,w=110,h=75}
f.pieces['arm_Ours2']={img=f.image,quad=love.graphics.newQuad(8119,1662,60,124,8192,2048),x=8119,y=1662,w=60,h=124}
f.pieces['leftForeArm_Shirt03']={img=f.image,quad=love.graphics.newQuad(5097,1884,33,93,8192,2048),x=5097,y=1884,w=33,h=93}
f.pieces['head_Robot_2']={img=f.image,quad=love.graphics.newQuad(5247,1630,150,150,8192,2048),x=5247,y=1630,w=150,h=150}
f.pieces['groin_Jupe03']={img=f.image,quad=love.graphics.newQuad(7169,1536,160,153,8192,2048),x=7169,y=1536,w=160,h=153}
f.pieces['right_foot_Ours2']={img=f.image,quad=love.graphics.newQuad(1693,1823,80,80,8192,2048),x=1693,y=1823,w=80,h=80}
f.pieces['leg_None']={img=f.image,quad=love.graphics.newQuad(8151,1536,29,124,8192,2048),x=8151,y=1536,w=29,h=124}
f.pieces['left_foot_Charlie']={img=f.image,quad=love.graphics.newQuad(6156,1837,80,80,8192,2048),x=6156,y=1837,w=80,h=80}
f.pieces['groin_Jupe02']={img=f.image,quad=love.graphics.newQuad(7329,1536,160,153,8192,2048),x=7329,y=1536,w=160,h=153}
f.pieces['Objet_Dildo2']={img=f.image,quad=love.graphics.newQuad(4409,1786,186,87,8192,2048),x=4409,y=1786,w=186,h=87}
f.pieces['torso_Terro']={img=f.image,quad=love.graphics.newQuad(790,1685,133,148,8192,2048),x=790,y=1685,w=133,h=148}
f.pieces['groin_Slip Dalai']={img=f.image,quad=love.graphics.newQuad(1055,1898,54,53,8192,2048),x=1055,y=1898,w=54,h=53}
f.pieces['doorClose']={img=f.image,quad=love.graphics.newQuad(7168,768,1024,768,8192,2048),x=7168,y=768,w=1024,h=768}
f.pieces['head_Vador']={img=f.image,quad=love.graphics.newQuad(2777,1536,200,200,8192,2048),x=2777,y=1536,w=200,h=200}
f.pieces['groin_3']={img=f.image,quad=love.graphics.newQuad(1375,1898,53,53,8192,2048),x=1375,y=1898,w=53,h=53}
f.pieces['rightForeArm_Rabbin']={img=f.image,quad=love.graphics.newQuad(5954,1880,33,93,8192,2048),x=5954,y=1880,w=33,h=93}
f.pieces['rightForeArm_Vador']={img=f.image,quad=love.graphics.newQuad(2659,1884,33,93,8192,2048),x=2659,y=1884,w=33,h=93}
f.pieces['stickers_pizza']={img=f.image,quad=love.graphics.newQuad(6741,1788,126,100,8192,2048),x=6741,y=1788,w=126,h=100}
f.pieces['torso_Shirt01']={img=f.image,quad=love.graphics.newQuad(5097,1736,111,148,8192,2048),x=5097,y=1736,w=111,h=148}
f.pieces['head_Long_Black_Hair']={img=f.image,quad=love.graphics.newQuad(3521,1536,138,250,8192,2048),x=3521,y=1536,w=138,h=250}
f.pieces['head_3']={img=f.image,quad=love.graphics.newQuad(6408,1806,103,103,8192,2048),x=6408,y=1806,w=103,h=103}
f.pieces['torsoW_1']={img=f.image,quad=love.graphics.newQuad(2432,1736,111,148,8192,2048),x=2432,y=1736,w=111,h=148}
f.pieces['head_Charlie_2']={img=f.image,quad=love.graphics.newQuad(2577,1536,200,200,8192,2048),x=2577,y=1536,w=200,h=200}
f.pieces['Objet_Robot2']={img=f.image,quad=love.graphics.newQuad(4625,1536,182,186,8192,2048),x=4625,y=1536,w=182,h=186}
f.pieces['torso_Vador']={img=f.image,quad=love.graphics.newQuad(3632,1786,111,148,8192,2048),x=3632,y=1786,w=111,h=148}
f.pieces['head_Robot_1']={img=f.image,quad=love.graphics.newQuad(7969,1662,150,150,8192,2048),x=7969,y=1662,w=150,h=150}
f.pieces['left_foot_Ours']={img=f.image,quad=love.graphics.newQuad(7579,1827,80,80,8192,2048),x=7579,y=1827,w=80,h=80}
f.pieces['torso_Shirt03']={img=f.image,quad=love.graphics.newQuad(3965,1786,111,148,8192,2048),x=3965,y=1786,w=111,h=148}
f.pieces['head_Ours']={img=f.image,quad=love.graphics.newQuad(1977,1536,200,200,8192,2048),x=1977,y=1536,w=200,h=200}
f.pieces['stickers_jihad']={img=f.image,quad=love.graphics.newQuad(6153,1716,141,121,8192,2048),x=6153,y=1716,w=141,h=121}
f.pieces['head_2']={img=f.image,quad=love.graphics.newQuad(6636,1776,103,103,8192,2048),x=6636,y=1776,w=103,h=103}
f.pieces['leftForeArm_Rabbin']={img=f.image,quad=love.graphics.newQuad(3147,1888,33,93,8192,2048),x=3147,y=1888,w=33,h=93}
f.pieces['torso_1']={img=f.image,quad=love.graphics.newQuad(4298,1786,111,148,8192,2048),x=4298,y=1786,w=111,h=148}
f.pieces['head_Blond_Hair']={img=f.image,quad=love.graphics.newQuad(1475,1685,138,138,8192,2048),x=1475,y=1685,w=138,h=138}
f.pieces['groin_1']={img=f.image,quad=love.graphics.newQuad(1428,1898,53,53,8192,2048),x=1428,y=1898,w=53,h=53}
f.pieces['rightFoot_2']={img=f.image,quad=love.graphics.newQuad(1473,1823,110,75,8192,2048),x=1473,y=1823,w=110,h=75}
f.pieces['cursor_down']={img=f.image,quad=love.graphics.newQuad(2473,1884,60,60,8192,2048),x=2473,y=1884,w=60,h=60}
f.pieces['groin_Burka']={img=f.image,quad=love.graphics.newQuad(0,1536,185,500,8192,2048),x=0,y=1536,w=185,h=500}
f.pieces['leg_Burka']={img=f.image,quad=love.graphics.newQuad(7939,1684,29,124,8192,2048),x=7939,y=1684,w=29,h=124}
f.pieces['leg_Ours2']={img=f.image,quad=love.graphics.newQuad(6455,1656,60,124,8192,2048),x=6455,y=1656,w=60,h=124}
f.pieces['leftFoot_6']={img=f.image,quad=love.graphics.newQuad(5888,1536,108,268,8192,2048),x=5888,y=1536,w=108,h=268}
f.pieces['head_Long_Brown_Hair']={img=f.image,quad=love.graphics.newQuad(4349,1536,138,250,8192,2048),x=4349,y=1536,w=138,h=250}
f.pieces['head_hat_Dalai']={img=f.image,quad=love.graphics.newQuad(3935,1536,138,250,8192,2048),x=3935,y=1536,w=138,h=250}
f.pieces['leftFoot_7']={img=f.image,quad=love.graphics.newQuad(1143,1823,110,75,8192,2048),x=1143,y=1823,w=110,h=75}
f.pieces['stickers_ymca']={img=f.image,quad=love.graphics.newQuad(370,1864,75,63,8192,2048),x=370,y=1864,w=75,h=63}
f.pieces['head_Burka']={img=f.image,quad=love.graphics.newQuad(7307,1689,138,138,8192,2048),x=7307,y=1689,w=138,h=138}
f.pieces['torso_Robot']={img=f.image,quad=love.graphics.newQuad(5247,1780,111,148,8192,2048),x=5247,y=1780,w=111,h=148}
f.pieces['rightFoot_4']={img=f.image,quad=love.graphics.newQuad(8072,1812,110,75,8192,2048),x=8072,y=1812,w=110,h=75}
f.pieces['groin_Jupe01']={img=f.image,quad=love.graphics.newQuad(6741,1536,248,102,8192,2048),x=6741,y=1536,w=248,h=102}
f.pieces['rightForeArm_pape']={img=f.image,quad=love.graphics.newQuad(2791,1884,33,93,8192,2048),x=2791,y=1884,w=33,h=93}
f.pieces['arm_Charlie2']={img=f.image,quad=love.graphics.newQuad(7781,1689,24,100,8192,2048),x=7781,y=1689,w=24,h=100}
f.pieces['arm_3']={img=f.image,quad=love.graphics.newQuad(8180,1625,12,89,8192,2048),x=8180,y=1625,w=12,h=89}
f.pieces['torso_Shirt04']={img=f.image,quad=love.graphics.newQuad(3854,1786,111,148,8192,2048),x=3854,y=1786,w=111,h=148}
f.anim = {}
return f