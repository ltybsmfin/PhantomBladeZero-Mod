StructuredBuffer<float4> t0 : register(t0);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t3 : register(t3);

StructuredBuffer<float4> t4 : register(t4);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t9 : register(t9);

Texture2D<float4> t10 : register(t10);

Texture2D<float4> t11 : register(t11);

Texture2D<float4> t12 : register(t12);

Texture2D<float4> t13 : register(t13);

Texture3D<float4> t14 : register(t14);

Texture2D<uint4> t15 : register(t15);

Texture2D<uint4> t16 : register(t16);

Texture2D<uint4> t17 : register(t17);

Texture2D<uint4> t18 : register(t18);

Texture2D<uint4> t19 : register(t19);

Texture2D<uint4> t20 : register(t20);

Texture2D<float4> t21 : register(t21);

Texture2D<float4> t22 : register(t22);

Texture2D<float4> t23 : register(t23);

Texture2D<float4> t24 : register(t24);

Texture2D<float4> t25 : register(t25);

RWStructuredBuffer<uint> u0 : register(u0);

cbuffer cb0 : register(b0) {
  float4 View_000[4] : packoffset(c000.x);
  float4 View_064[4] : packoffset(c004.x);
  float4 View_128[4] : packoffset(c008.x);
  float4 View_192[4] : packoffset(c012.x);
  float4 View_256[4] : packoffset(c016.x);
  float4 View_320[4] : packoffset(c020.x);
  float4 View_384[4] : packoffset(c024.x);
  float4 View_448[4] : packoffset(c028.x);
  float4 View_512[4] : packoffset(c032.x);
  float4 View_576[4] : packoffset(c036.x);
  float4 View_640[4] : packoffset(c040.x);
  float4 View_704[4] : packoffset(c044.x);
  float4 View_768[4] : packoffset(c048.x);
  float4 View_832[4] : packoffset(c052.x);
  float4 View_896[4] : packoffset(c056.x);
  float4 View_960[4] : packoffset(c060.x);
  float4 View_1024[4] : packoffset(c064.x);
  float4 View_1088[4] : packoffset(c068.x);
  float3 View_1152 : packoffset(c072.x);
  float View_1164 : packoffset(c072.w);
  float3 View_1168 : packoffset(c073.x);
  float View_1180 : packoffset(c073.w);
  float3 View_1184 : packoffset(c074.x);
  float View_1196 : packoffset(c074.w);
  float3 View_1200 : packoffset(c075.x);
  float View_1212 : packoffset(c075.w);
  float3 View_1216 : packoffset(c076.x);
  float View_1228 : packoffset(c076.w);
  float3 View_1232 : packoffset(c077.x);
  float View_1244 : packoffset(c077.w);
  float4 View_1248 : packoffset(c078.x);
  float4 View_1264 : packoffset(c079.x);
  float3 View_1280 : packoffset(c080.x);
  float View_1292 : packoffset(c080.w);
  float3 View_1296 : packoffset(c081.x);
  float View_1308 : packoffset(c081.w);
  float3 View_1312 : packoffset(c082.x);
  float View_1324 : packoffset(c082.w);
  float3 View_1328 : packoffset(c083.x);
  float View_1340 : packoffset(c083.w);
  float3 View_1344 : packoffset(c084.x);
  float View_1356 : packoffset(c084.w);
  float3 View_1360 : packoffset(c085.x);
  float View_1372 : packoffset(c085.w);
  float4 View_1376[4] : packoffset(c086.x);
  float4 View_1440[4] : packoffset(c090.x);
  float4 View_1504[4] : packoffset(c094.x);
  float4 View_1568[4] : packoffset(c098.x);
  float4 View_1632[4] : packoffset(c102.x);
  float4 View_1696[4] : packoffset(c106.x);
  float4 View_1760[4] : packoffset(c110.x);
  float3 View_1824 : packoffset(c114.x);
  float View_1836 : packoffset(c114.w);
  float3 View_1840 : packoffset(c115.x);
  float View_1852 : packoffset(c115.w);
  float3 View_1856 : packoffset(c116.x);
  float View_1868 : packoffset(c116.w);
  float3 View_1872 : packoffset(c117.x);
  float View_1884 : packoffset(c117.w);
  float3 View_1888 : packoffset(c118.x);
  float View_1900 : packoffset(c118.w);
  float3 View_1904 : packoffset(c119.x);
  float View_1916 : packoffset(c119.w);
  float3 View_1920 : packoffset(c120.x);
  float View_1932 : packoffset(c120.w);
  float3 View_1936 : packoffset(c121.x);
  float View_1948 : packoffset(c121.w);
  float3 View_1952 : packoffset(c122.x);
  float View_1964 : packoffset(c122.w);
  float3 View_1968 : packoffset(c123.x);
  float View_1980 : packoffset(c123.w);
  float3 View_1984 : packoffset(c124.x);
  float View_1996 : packoffset(c124.w);
  float3 View_2000 : packoffset(c125.x);
  float View_2012 : packoffset(c125.w);
  float3 View_2016 : packoffset(c126.x);
  float View_2028 : packoffset(c126.w);
  float3 View_2032 : packoffset(c127.x);
  float View_2044 : packoffset(c127.w);
  float4 View_2048[4] : packoffset(c128.x);
  float4 View_2112[4] : packoffset(c132.x);
  float4 View_2176[4] : packoffset(c136.x);
  float4 View_2240[4] : packoffset(c140.x);
  float4 View_2304 : packoffset(c144.x);
  float4 View_2320 : packoffset(c145.x);
  float2 View_2336 : packoffset(c146.x);
  float2 View_2344 : packoffset(c146.z);
  float2 View_2352 : packoffset(c147.x);
  float2 View_2360 : packoffset(c147.z);
  float4 View_2368 : packoffset(c148.x);
  float4 View_2384 : packoffset(c149.x);
  int4 View_2400 : packoffset(c150.x);
  float4 View_2416 : packoffset(c151.x);
  float4 View_2432 : packoffset(c152.x);
  float4 View_2448 : packoffset(c153.x);
  float4 View_2464 : packoffset(c154.x);
  float2 View_2480 : packoffset(c155.x);
  float2 View_2488 : packoffset(c155.z);
  int View_2496 : packoffset(c156.x);
  float View_2500 : packoffset(c156.y);
  float View_2504 : packoffset(c156.z);
  float View_2508 : packoffset(c156.w);
  float4 View_2512 : packoffset(c157.x);
  float4 View_2528 : packoffset(c158.x);
  float4 View_2544 : packoffset(c159.x);
  float2 View_2560 : packoffset(c160.x);
  float2 View_2568 : packoffset(c160.z);
  float View_2576 : packoffset(c161.x);
  float View_2580 : packoffset(c161.y);
  float View_2584 : packoffset(c161.z);
  float View_2588 : packoffset(c161.w);
  float3 View_2592 : packoffset(c162.x);
  float View_2604 : packoffset(c162.w);
  float View_2608 : packoffset(c163.x);
  float View_2612 : packoffset(c163.y);
  float View_2616 : packoffset(c163.z);
  float View_2620 : packoffset(c163.w);
  float View_2624 : packoffset(c164.x);
  float View_2628 : packoffset(c164.y);
  float View_2632 : packoffset(c164.z);
  float View_2636 : packoffset(c164.w);
  float View_2640 : packoffset(c165.x);
  float View_2644 : packoffset(c165.y);
  float View_2648 : packoffset(c165.z);
  int View_2652 : packoffset(c165.w);
  int View_2656 : packoffset(c166.x);
  int View_2660 : packoffset(c166.y);
  int View_2664 : packoffset(c166.z);
  int View_2668 : packoffset(c166.w);
  int View_2672 : packoffset(c167.x);
  int View_2676 : packoffset(c167.y);
  int View_2680 : packoffset(c167.z);
  float View_2684 : packoffset(c167.w);
  float View_2688 : packoffset(c168.x);
  float View_2692 : packoffset(c168.y);
  float View_2696 : packoffset(c168.z);
  float View_2700 : packoffset(c168.w);
  float4 View_2704 : packoffset(c169.x);
  float3 View_2720 : packoffset(c170.x);
  float View_2732 : packoffset(c170.w);
  float4 View_2736[2] : packoffset(c171.x);
  float4 View_2768[2] : packoffset(c173.x);
  float4 View_2800 : packoffset(c175.x);
  float4 View_2816 : packoffset(c176.x);
  float View_2832 : packoffset(c177.x);
  float View_2836 : packoffset(c177.y);
  float View_2840 : packoffset(c177.z);
  float View_2844 : packoffset(c177.w);
  float View_2848 : packoffset(c178.x);
  float View_2852 : packoffset(c178.y);
  float View_2856 : packoffset(c178.z);
  float View_2860 : packoffset(c178.w);
  float View_2864 : packoffset(c179.x);
  float View_2868 : packoffset(c179.y);
  float View_2872 : packoffset(c179.z);
  float View_2876 : packoffset(c179.w);
  float3 View_2880 : packoffset(c180.x);
  float View_2892 : packoffset(c180.w);
  float3 View_2896 : packoffset(c181.x);
  float View_2908 : packoffset(c181.w);
  float3 View_2912 : packoffset(c182.x);
  float View_2924 : packoffset(c182.w);
  float3 View_2928 : packoffset(c183.x);
  float View_2940 : packoffset(c183.w);
  float4 View_2944[2] : packoffset(c184.x);
  float4 View_2976[2] : packoffset(c186.x);
  float4 View_3008[2] : packoffset(c188.x);
  float4 View_3040[2] : packoffset(c190.x);
  float4 View_3072[2] : packoffset(c192.x);
  float4 View_3104 : packoffset(c194.x);
  float3 View_3120 : packoffset(c195.x);
  float View_3132 : packoffset(c195.w);
  float4 View_3136 : packoffset(c196.x);
  float4 View_3152[4] : packoffset(c197.x);
  float4 View_3216 : packoffset(c201.x);
  float View_3232 : packoffset(c202.x);
  float View_3236 : packoffset(c202.y);
  float View_3240 : packoffset(c202.z);
  float View_3244 : packoffset(c202.w);
  float4 View_3248 : packoffset(c203.x);
  float View_3264 : packoffset(c204.x);
  float View_3268 : packoffset(c204.y);
  float View_3272 : packoffset(c204.z);
  float View_3276 : packoffset(c204.w);
  float View_3280 : packoffset(c205.x);
  float View_3284 : packoffset(c205.y);
  float View_3288 : packoffset(c205.z);
  float View_3292 : packoffset(c205.w);
  float3 View_3296 : packoffset(c206.x);
  float View_3308 : packoffset(c206.w);
  float View_3312 : packoffset(c207.x);
  float View_3316 : packoffset(c207.y);
  float View_3320 : packoffset(c207.z);
  float View_3324 : packoffset(c207.w);
  float4 View_3328 : packoffset(c208.x);
  float View_3344 : packoffset(c209.x);
  float View_3348 : packoffset(c209.y);
  float View_3352 : packoffset(c209.z);
  float View_3356 : packoffset(c209.w);
  float4 View_3360 : packoffset(c210.x);
  float View_3376 : packoffset(c211.x);
  float View_3380 : packoffset(c211.y);
  float View_3384 : packoffset(c211.z);
  float View_3388 : packoffset(c211.w);
  float4 View_3392[8] : packoffset(c212.x);
  float View_3520 : packoffset(c220.x);
  float View_3524 : packoffset(c220.y);
  float View_3528 : packoffset(c220.z);
  float View_3532 : packoffset(c220.w);
  int View_3536 : packoffset(c221.x);
  float View_3540 : packoffset(c221.y);
  float View_3544 : packoffset(c221.z);
  float View_3548 : packoffset(c221.w);
  float3 View_3552 : packoffset(c222.x);
  int View_3564 : packoffset(c222.w);
  float4 View_3568[6] : packoffset(c223.x);
  float4 View_3664[6] : packoffset(c229.x);
  float4 View_3760[6] : packoffset(c235.x);
  float4 View_3856[6] : packoffset(c241.x);
  float View_3952 : packoffset(c247.x);
  float View_3956 : packoffset(c247.y);
  int View_3960 : packoffset(c247.z);
  int View_3964 : packoffset(c247.w);
  float3 View_3968 : packoffset(c248.x);
  float View_3980 : packoffset(c248.w);
  float3 View_3984 : packoffset(c249.x);
  float View_3996 : packoffset(c249.w);
  float View_4000 : packoffset(c250.x);
  float View_4004 : packoffset(c250.y);
  int View_4008 : packoffset(c250.z);
  float View_4012 : packoffset(c250.w);
  float View_4016 : packoffset(c251.x);
  float View_4020 : packoffset(c251.y);
  float View_4024 : packoffset(c251.z);
  float View_4028 : packoffset(c251.w);
  float View_4032 : packoffset(c252.x);
  float View_4036 : packoffset(c252.y);
  int2 View_4040 : packoffset(c252.z);
  float View_4048 : packoffset(c253.x);
  float View_4052 : packoffset(c253.y);
  float View_4056 : packoffset(c253.z);
  float View_4060 : packoffset(c253.w);
  float3 View_4064 : packoffset(c254.x);
  float View_4076 : packoffset(c254.w);
  float3 View_4080 : packoffset(c255.x);
  float View_4092 : packoffset(c255.w);
  float2 View_4096 : packoffset(c256.x);
  float2 View_4104 : packoffset(c256.z);
  float2 View_4112 : packoffset(c257.x);
  float2 View_4120 : packoffset(c257.z);
  float2 View_4128 : packoffset(c258.x);
  float View_4136 : packoffset(c258.z);
  float View_4140 : packoffset(c258.w);
  float3 View_4144 : packoffset(c259.x);
  float View_4156 : packoffset(c259.w);
  float2 View_4160 : packoffset(c260.x);
  float2 View_4168 : packoffset(c260.z);
  float View_4176 : packoffset(c261.x);
  float View_4180 : packoffset(c261.y);
  float View_4184 : packoffset(c261.z);
  float View_4188 : packoffset(c261.w);
  float3 View_4192 : packoffset(c262.x);
  float View_4204 : packoffset(c262.w);
  float3 View_4208 : packoffset(c263.x);
  float View_4220 : packoffset(c263.w);
  float3 View_4224 : packoffset(c264.x);
  float View_4236 : packoffset(c264.w);
  float3 View_4240 : packoffset(c265.x);
  float View_4252 : packoffset(c265.w);
  float View_4256 : packoffset(c266.x);
  float View_4260 : packoffset(c266.y);
  float View_4264 : packoffset(c266.z);
  float View_4268 : packoffset(c266.w);
  float4 View_4272[2] : packoffset(c267.x);
  float4 View_4304 : packoffset(c269.x);
  int View_4320 : packoffset(c270.x);
  int View_4324 : packoffset(c270.y);
  int View_4328 : packoffset(c270.z);
  int View_4332 : packoffset(c270.w);
  int View_4336 : packoffset(c271.x);
  int View_4340 : packoffset(c271.y);
  int View_4344 : packoffset(c271.z);
  float View_4348 : packoffset(c271.w);
  float4 View_4352 : packoffset(c272.x);
  int View_4368 : packoffset(c273.x);
  int View_4372 : packoffset(c273.y);
  int View_4376 : packoffset(c273.z);
  float View_4380 : packoffset(c273.w);
  float4 View_4384 : packoffset(c274.x);
  float4 View_4400 : packoffset(c275.x);
  float4 View_4416 : packoffset(c276.x);
  float3 View_4432 : packoffset(c277.x);
  float View_4444 : packoffset(c277.w);
  int View_4448 : packoffset(c278.x);
  int View_4452 : packoffset(c278.y);
  int View_4456 : packoffset(c278.z);
  int View_4460 : packoffset(c278.w);
  int4 View_4464[32] : packoffset(c279.x);
  int View_4976 : packoffset(c311.x);
  float View_4980 : packoffset(c311.y);
  float View_4984 : packoffset(c311.z);
  float View_4988 : packoffset(c311.w);
  float4 View_4992 : packoffset(c312.x);
  float4 View_5008 : packoffset(c313.x);
  float4 View_5024 : packoffset(c314.x);
  float4 View_5040 : packoffset(c315.x);
  float2 View_5056 : packoffset(c316.x);
  float View_5064 : packoffset(c316.z);
  float View_5068 : packoffset(c316.w);
  float4 View_5072 : packoffset(c317.x);
  float4 View_5088 : packoffset(c318.x);
  float4 View_5104 : packoffset(c319.x);
  float View_5120 : packoffset(c320.x);
  float View_5124 : packoffset(c320.y);
  float View_5128 : packoffset(c320.z);
  int View_5132 : packoffset(c320.w);
  int4 View_5136 : packoffset(c321.x);
  int View_5152 : packoffset(c322.x);
  int View_5156 : packoffset(c322.y);
  int View_5160 : packoffset(c322.z);
  int View_5164 : packoffset(c322.w);
  int View_5168 : packoffset(c323.x);
  int View_5172 : packoffset(c323.y);
  int View_5176 : packoffset(c323.z);
  int View_5180 : packoffset(c323.w);
  int View_5184 : packoffset(c324.x);
  int View_5188 : packoffset(c324.y);
  int View_5192 : packoffset(c324.z);
  int View_5196 : packoffset(c324.w);
  int View_5200 : packoffset(c325.x);
  int View_5204 : packoffset(c325.y);
  int View_5208 : packoffset(c325.z);
  int View_5212 : packoffset(c325.w);
  int View_5216 : packoffset(c326.x);
  int View_5220 : packoffset(c326.y);
  int View_5224 : packoffset(c326.z);
  int View_5228 : packoffset(c326.w);
  int View_5232 : packoffset(c327.x);
  int View_5236 : packoffset(c327.y);
  int View_5240 : packoffset(c327.z);
  int View_5244 : packoffset(c327.w);
  int View_5248 : packoffset(c328.x);
  int View_5252 : packoffset(c328.y);
  int View_5256 : packoffset(c328.z);
  int View_5260 : packoffset(c328.w);
  int View_5264 : packoffset(c329.x);
  int View_5268 : packoffset(c329.y);
  int View_5272 : packoffset(c329.z);
  int View_5276 : packoffset(c329.w);
  int View_5280 : packoffset(c330.x);
  int View_5284 : packoffset(c330.y);
  int View_5288 : packoffset(c330.z);
  int View_5292 : packoffset(c330.w);
  int View_5296 : packoffset(c331.x);
  int View_5300 : packoffset(c331.y);
  int View_5304 : packoffset(c331.z);
  int View_5308 : packoffset(c331.w);
  int View_5312 : packoffset(c332.x);
  int View_5316 : packoffset(c332.y);
  int View_5320 : packoffset(c332.z);
  int View_5324 : packoffset(c332.w);
  int View_5328 : packoffset(c333.x);
  int View_5332 : packoffset(c333.y);
  int View_5336 : packoffset(c333.z);
  int View_5340 : packoffset(c333.w);
  int View_5344 : packoffset(c334.x);
  int View_5348 : packoffset(c334.y);
  int View_5352 : packoffset(c334.z);
  int View_5356 : packoffset(c334.w);
  int View_5360 : packoffset(c335.x);
  int View_5364 : packoffset(c335.y);
  int View_5368 : packoffset(c335.z);
  int View_5372 : packoffset(c335.w);
  int View_5376 : packoffset(c336.x);
  int View_5380 : packoffset(c336.y);
  int View_5384 : packoffset(c336.z);
  int View_5388 : packoffset(c336.w);
  int View_5392 : packoffset(c337.x);
  int View_5396 : packoffset(c337.y);
  int View_5400 : packoffset(c337.z);
  int View_5404 : packoffset(c337.w);
  int View_5408 : packoffset(c338.x);
  int View_5412 : packoffset(c338.y);
  int View_5416 : packoffset(c338.z);
  int View_5420 : packoffset(c338.w);
  int View_5424 : packoffset(c339.x);
  int View_5428 : packoffset(c339.y);
  int View_5432 : packoffset(c339.z);
  int View_5436 : packoffset(c339.w);
  int View_5440 : packoffset(c340.x);
  int View_5444 : packoffset(c340.y);
  int View_5448 : packoffset(c340.z);
  int View_5452 : packoffset(c340.w);
  int View_5456 : packoffset(c341.x);
  int View_5460 : packoffset(c341.y);
  int View_5464 : packoffset(c341.z);
  int View_5468 : packoffset(c341.w);
  int View_5472 : packoffset(c342.x);
  int View_5476 : packoffset(c342.y);
  int View_5480 : packoffset(c342.z);
  int View_5484 : packoffset(c342.w);
  int View_5488 : packoffset(c343.x);
  int View_5492 : packoffset(c343.y);
  int View_5496 : packoffset(c343.z);
  int View_5500 : packoffset(c343.w);
  int View_5504 : packoffset(c344.x);
  int View_5508 : packoffset(c344.y);
  int View_5512 : packoffset(c344.z);
  int View_5516 : packoffset(c344.w);
  int View_5520 : packoffset(c345.x);
  int View_5524 : packoffset(c345.y);
  int View_5528 : packoffset(c345.z);
  int View_5532 : packoffset(c345.w);
  int View_5536 : packoffset(c346.x);
  int View_5540 : packoffset(c346.y);
  int View_5544 : packoffset(c346.z);
  int View_5548 : packoffset(c346.w);
  int View_5552 : packoffset(c347.x);
  int View_5556 : packoffset(c347.y);
  int View_5560 : packoffset(c347.z);
  int View_5564 : packoffset(c347.w);
  int View_5568 : packoffset(c348.x);
  int View_5572 : packoffset(c348.y);
  int View_5576 : packoffset(c348.z);
  int View_5580 : packoffset(c348.w);
  int View_5584 : packoffset(c349.x);
  int View_5588 : packoffset(c349.y);
  int View_5592 : packoffset(c349.z);
  int View_5596 : packoffset(c349.w);
  int View_5600 : packoffset(c350.x);
  int View_5604 : packoffset(c350.y);
  int View_5608 : packoffset(c350.z);
  int View_5612 : packoffset(c350.w);
  int View_5616 : packoffset(c351.x);
  int View_5620 : packoffset(c351.y);
  int View_5624 : packoffset(c351.z);
  int View_5628 : packoffset(c351.w);
  int View_5632 : packoffset(c352.x);
  int View_5636 : packoffset(c352.y);
  int View_5640 : packoffset(c352.z);
  int View_5644 : packoffset(c352.w);
  int View_5648 : packoffset(c353.x);
  int View_5652 : packoffset(c353.y);
  int View_5656 : packoffset(c353.z);
  int View_5660 : packoffset(c353.w);
  int View_5664 : packoffset(c354.x);
  int View_5668 : packoffset(c354.y);
  int View_5672 : packoffset(c354.z);
  int View_5676 : packoffset(c354.w);
  int View_5680 : packoffset(c355.x);
  int View_5684 : packoffset(c355.y);
  int View_5688 : packoffset(c355.z);
  int View_5692 : packoffset(c355.w);
  int View_5696 : packoffset(c356.x);
  int View_5700 : packoffset(c356.y);
  int View_5704 : packoffset(c356.z);
  int View_5708 : packoffset(c356.w);
  int View_5712 : packoffset(c357.x);
  int View_5716 : packoffset(c357.y);
  int View_5720 : packoffset(c357.z);
  int View_5724 : packoffset(c357.w);
  int View_5728 : packoffset(c358.x);
  int View_5732 : packoffset(c358.y);
  int View_5736 : packoffset(c358.z);
  int View_5740 : packoffset(c358.w);
  int View_5744 : packoffset(c359.x);
  int View_5748 : packoffset(c359.y);
  int View_5752 : packoffset(c359.z);
  int View_5756 : packoffset(c359.w);
  int View_5760 : packoffset(c360.x);
  int View_5764 : packoffset(c360.y);
  int View_5768 : packoffset(c360.z);
  int View_5772 : packoffset(c360.w);
  int View_5776 : packoffset(c361.x);
  int View_5780 : packoffset(c361.y);
  int View_5784 : packoffset(c361.z);
  int View_5788 : packoffset(c361.w);
  int View_5792 : packoffset(c362.x);
  int View_5796 : packoffset(c362.y);
  int View_5800 : packoffset(c362.z);
  int View_5804 : packoffset(c362.w);
  int View_5808 : packoffset(c363.x);
  int View_5812 : packoffset(c363.y);
  int View_5816 : packoffset(c363.z);
  int View_5820 : packoffset(c363.w);
  int View_5824 : packoffset(c364.x);
  int View_5828 : packoffset(c364.y);
  int View_5832 : packoffset(c364.z);
  int View_5836 : packoffset(c364.w);
  int View_5840 : packoffset(c365.x);
  int View_5844 : packoffset(c365.y);
  int View_5848 : packoffset(c365.z);
  int View_5852 : packoffset(c365.w);
  int View_5856 : packoffset(c366.x);
  int View_5860 : packoffset(c366.y);
  int View_5864 : packoffset(c366.z);
  int View_5868 : packoffset(c366.w);
  int View_5872 : packoffset(c367.x);
  int View_5876 : packoffset(c367.y);
  int View_5880 : packoffset(c367.z);
  int View_5884 : packoffset(c367.w);
  float4 View_5888 : packoffset(c368.x);
  float View_5904 : packoffset(c369.x);
  float View_5908 : packoffset(c369.y);
  int View_5912 : packoffset(c369.z);
  int View_5916 : packoffset(c369.w);
  int View_5920 : packoffset(c370.x);
  int View_5924 : packoffset(c370.y);
  int View_5928 : packoffset(c370.z);
  int View_5932 : packoffset(c370.w);
  float4 View_5936 : packoffset(c371.x);
  int View_5952 : packoffset(c372.x);
  int View_5956 : packoffset(c372.y);
  int View_5960 : packoffset(c372.z);
  int View_5964 : packoffset(c372.w);
  int View_5968 : packoffset(c373.x);
  int View_5972 : packoffset(c373.y);
  int View_5976 : packoffset(c373.z);
  int View_5980 : packoffset(c373.w);
  int View_5984 : packoffset(c374.x);
  int View_5988 : packoffset(c374.y);
  int View_5992 : packoffset(c374.z);
  int View_5996 : packoffset(c374.w);
  int View_6000 : packoffset(c375.x);
  int View_6004 : packoffset(c375.y);
  int View_6008 : packoffset(c375.z);
  int View_6012 : packoffset(c375.w);
  int3 View_6016 : packoffset(c376.x);
  int View_6028 : packoffset(c376.w);
  int3 View_6032 : packoffset(c377.x);
  int View_6044 : packoffset(c377.w);
  float3 View_6048 : packoffset(c378.x);
  float View_6060 : packoffset(c378.w);
  float3 View_6064 : packoffset(c379.x);
  float View_6076 : packoffset(c379.w);
  float4 View_6080 : packoffset(c380.x);
};

cbuffer cb1 : register(b1) {
  struct FMaterialCollection0Constants {
    float4 FMaterialCollection0Constants_000[42];
  } MaterialCollection0_000 : packoffset(c000.x);
};

cbuffer cb2 : register(b2) {
  int4 Material_000[12] : packoffset(c000.x);
  int4 Material_192[5] : packoffset(c012.x);
  float4 Material_272[50] : packoffset(c017.x);
  int Material_1072 : packoffset(c067.x);
  int Material_1076 : packoffset(c067.y);
  int Material_1080 : packoffset(c067.z);
  int Material_1084 : packoffset(c067.w);
  int Material_1088 : packoffset(c068.x);
  int Material_1092 : packoffset(c068.y);
  int Material_1096 : packoffset(c068.z);
  int Material_1100 : packoffset(c068.w);
  int Material_1104 : packoffset(c069.x);
  int Material_1108 : packoffset(c069.y);
  int Material_1112 : packoffset(c069.z);
  int Material_1116 : packoffset(c069.w);
  int Material_1120 : packoffset(c070.x);
  int Material_1124 : packoffset(c070.y);
  int Material_1128 : packoffset(c070.z);
  int Material_1132 : packoffset(c070.w);
  int Material_1136 : packoffset(c071.x);
  int Material_1140 : packoffset(c071.y);
  int Material_1144 : packoffset(c071.z);
  int Material_1148 : packoffset(c071.w);
  int Material_1152 : packoffset(c072.x);
  int Material_1156 : packoffset(c072.y);
  int Material_1160 : packoffset(c072.z);
  int Material_1164 : packoffset(c072.w);
  int Material_1168 : packoffset(c073.x);
  int Material_1172 : packoffset(c073.y);
  int Material_1176 : packoffset(c073.z);
  int Material_1180 : packoffset(c073.w);
  int Material_1184 : packoffset(c074.x);
  int Material_1188 : packoffset(c074.y);
  int Material_1192 : packoffset(c074.z);
  int Material_1196 : packoffset(c074.w);
  int Material_1200 : packoffset(c075.x);
  int Material_1204 : packoffset(c075.y);
  int Material_1208 : packoffset(c075.z);
  int Material_1212 : packoffset(c075.w);
  int Material_1216 : packoffset(c076.x);
  int Material_1220 : packoffset(c076.y);
  int Material_1224 : packoffset(c076.z);
  int Material_1228 : packoffset(c076.w);
  int Material_1232 : packoffset(c077.x);
  int Material_1236 : packoffset(c077.y);
  int Material_1240 : packoffset(c077.z);
  int Material_1244 : packoffset(c077.w);
  int Material_1248 : packoffset(c078.x);
  int Material_1252 : packoffset(c078.y);
  int Material_1256 : packoffset(c078.z);
  int Material_1260 : packoffset(c078.w);
  int Material_1264 : packoffset(c079.x);
  int Material_1268 : packoffset(c079.y);
  int Material_1272 : packoffset(c079.z);
  int Material_1276 : packoffset(c079.w);
  int Material_1280 : packoffset(c080.x);
  int Material_1284 : packoffset(c080.y);
  int Material_1288 : packoffset(c080.z);
  int Material_1292 : packoffset(c080.w);
  int Material_1296 : packoffset(c081.x);
  int Material_1300 : packoffset(c081.y);
  int Material_1304 : packoffset(c081.z);
  int Material_1308 : packoffset(c081.w);
  int Material_1312 : packoffset(c082.x);
  int Material_1316 : packoffset(c082.y);
  int Material_1320 : packoffset(c082.z);
  int Material_1324 : packoffset(c082.w);
  int Material_1328 : packoffset(c083.x);
  int Material_1332 : packoffset(c083.y);
  int Material_1336 : packoffset(c083.z);
  int Material_1340 : packoffset(c083.w);
  int Material_1344 : packoffset(c084.x);
  int Material_1348 : packoffset(c084.y);
  int Material_1352 : packoffset(c084.z);
  int Material_1356 : packoffset(c084.w);
  int Material_1360 : packoffset(c085.x);
  int Material_1364 : packoffset(c085.y);
  int Material_1368 : packoffset(c085.z);
  int Material_1372 : packoffset(c085.w);
  int Material_1376 : packoffset(c086.x);
  int Material_1380 : packoffset(c086.y);
  int Material_1384 : packoffset(c086.z);
  int Material_1388 : packoffset(c086.w);
  int Material_1392 : packoffset(c087.x);
  int Material_1396 : packoffset(c087.y);
  int Material_1400 : packoffset(c087.z);
  int Material_1404 : packoffset(c087.w);
  int Material_1408 : packoffset(c088.x);
  int Material_1412 : packoffset(c088.y);
  int Material_1416 : packoffset(c088.z);
  int Material_1420 : packoffset(c088.w);
  int Material_1424 : packoffset(c089.x);
  int Material_1428 : packoffset(c089.y);
  int Material_1432 : packoffset(c089.z);
};

SamplerState s0 : register(s0);

SamplerState s1 : register(s1);

SamplerState s2 : register(s2);

SamplerState s3 : register(s3);

SamplerState s4 : register(s4);

SamplerState s5 : register(s5);

SamplerState s6 : register(s6);

SamplerState s7 : register(s7);

SamplerState s8 : register(s8);

SamplerState s9 : register(s9);

SamplerState s10 : register(s10);

SamplerState s11 : register(s11);

SamplerState s12 : register(s12);

struct OutputSignature {
  float4 SV_Target : SV_Target;
  float4 SV_Target_1 : SV_Target1;
  float4 SV_Target_2 : SV_Target2;
  float4 SV_Target_3 : SV_Target3;
  float4 SV_Target_4 : SV_Target4;
  float Depth : SV_Depth;
};

// ===== Blender 节点等价实现 =====
float ynEase(float t) { return t * t * (3.0f - 2.0f * t); }

float ynEaseRamp4(float x, float4 p, float4 v) {
  if (x <= p.x) return v.x;
  if (x <= p.y) return lerp(v.x, v.y, ynEase(saturate((x - p.x) / max(1e-6f, p.y - p.x))));
  if (x <= p.z) return lerp(v.y, v.z, ynEase(saturate((x - p.y) / max(1e-6f, p.z - p.y))));
  if (x <= p.w) return lerp(v.z, v.w, ynEase(saturate((x - p.z) / max(1e-6f, p.w - p.z))));
  return v.w;
}

float ynConstRamp(float x, float p1, float v1, float p2, float v2) {
  if (x < p1) return 0.0f;
  if (x < p2) return v1;
  return v2;
}

float3 ynHSV(float3 c, float s, float v) {
  float mx = max(c.r, max(c.g, c.b));
  float mn = min(c.r, min(c.g, c.b));
  float d = mx - mn;
  float3 hsv;
  hsv.z = mx;
  hsv.y = (mx <= 0.0f) ? 0.0f : d / mx;
  if (d <= 0.0f) hsv.x = 0.0f;
  else if (mx == c.r) hsv.x = frac((c.g - c.b) / d / 6.0f);
  else if (mx == c.g) hsv.x = ((c.b - c.r) / d + 2.0f) / 6.0f;
  else hsv.x = ((c.r - c.g) / d + 4.0f) / 6.0f;
  hsv.y = saturate(hsv.y * s);
  hsv.z = hsv.z * v;
  float3 rgb = saturate(abs(frac(hsv.x + float3(0.0f, 0.6666667f, 0.3333333f)) * 6.0f - 3.0f) - 1.0f);
  return lerp(hsv.z.xxx, rgb * hsv.z, hsv.y);
}

float ynOverlayChannel(float a, float b) {
  return (a < 0.5f) ? (2.0f * a * b) : (1.0f - 2.0f * (1.0f - a) * (1.0f - b));
}

float3 ynOverlay(float3 a, float3 b, float fac) {
  float3 o = float3(ynOverlayChannel(a.r, b.r), ynOverlayChannel(a.g, b.g), ynOverlayChannel(a.b, b.b));
  return lerp(a, o, saturate(fac));
}

OutputSignature main(
  linear float4 TEXCOORD10_centroid : TEXCOORD10_centroid,
  linear float4 TEXCOORD11_centroid : TEXCOORD11_centroid,
  linear float4 TEXCOORD : TEXCOORD0,
  linear float4 TEXCOORD1 : TEXCOORD1,
  linear float4 TEXCOORD2 : TEXCOORD2,
  linear float4 TEXCOORD3 : TEXCOORD3,
  nointerpolation uint PRIMITIVE_ID : PRIMITIVE_ID,
  nointerpolation float PER_INSTANCE_RANDOM : PER_INSTANCE_RANDOM,
  nointerpolation uint SV_IsFrontFace : SV_IsFrontFace,
  linear float3 TEXCOORD_9 : TEXCOORD9,
  noperspective float4 SV_Position : SV_Position
) {
  float4 SV_Target;
  float4 SV_Target_1;
  float4 SV_Target_2;
  float4 SV_Target_3;
  float4 SV_Target_4;
  float _44[4];
  float _45[4];
  float _46[4];
  float _47[4];
  float _48[4];
  float _49[4];
  float _71[3];
  float _72[3];
  float _145 = ((TEXCOORD10_centroid.z * TEXCOORD11_centroid.y) - (TEXCOORD10_centroid.y * TEXCOORD11_centroid.z)) * TEXCOORD11_centroid.w;
  float _146 = ((TEXCOORD10_centroid.x * TEXCOORD11_centroid.z) - (TEXCOORD10_centroid.z * TEXCOORD11_centroid.x)) * TEXCOORD11_centroid.w;
  float _147 = ((TEXCOORD10_centroid.y * TEXCOORD11_centroid.x) - (TEXCOORD10_centroid.x * TEXCOORD11_centroid.y)) * TEXCOORD11_centroid.w;
  float _148 = SV_Position.w * SV_Position.z;
  float _164 = mad(1.0f, (View_704[3].w), mad(SV_Position.z, (View_704[2].w), mad(SV_Position.y, (View_704[1].w), (SV_Position.x * (View_704[0].w)))));
  float _165 = mad(1.0f, (View_704[3].x), mad(SV_Position.z, (View_704[2].x), mad(SV_Position.y, (View_704[1].x), (SV_Position.x * (View_704[0].x))))) / _164;
  float _166 = mad(1.0f, (View_704[3].y), mad(SV_Position.z, (View_704[2].y), mad(SV_Position.y, (View_704[1].y), (SV_Position.x * (View_704[0].y))))) / _164;
  float _167 = mad(1.0f, (View_704[3].z), mad(SV_Position.z, (View_704[2].z), mad(SV_Position.y, (View_704[1].z), (SV_Position.x * (View_704[0].z))))) / _164;
  float _168 = _165 - View_1984.x;
  float _169 = _166 - View_1984.y;
  float _170 = _167 - View_1984.z;
  float _171 = mad(View_1936.x, 2097152.0f, _168);
  float _172 = mad(View_1936.y, 2097152.0f, _169);
  float _173 = mad(View_1936.z, 2097152.0f, _170);
  float _177 = _168 - mad((-0.0f - View_1936.x), 2097152.0f, _171);
  float _178 = _169 - mad((-0.0f - View_1936.y), 2097152.0f, _172);
  float _179 = _170 - mad((-0.0f - View_1936.z), 2097152.0f, _173);
  float _180 = -0.0f - _165;
  float _181 = -0.0f - _166;
  float _182 = -0.0f - _167;
  float _184 = rsqrt(dot(float3(_180, _181, _182), float3(_180, _181, _182)));
  bool _191 = ((View_448[3].w) >= 1.0f);
  float _192 = select(_191, (-0.0f - View_1168.x), (_184 * _180));
  float _193 = select(_191, (-0.0f - View_1168.y), (_184 * _181));
  float _194 = select(_191, (-0.0f - View_1168.z), (_184 * _182));
  uint _195 = PRIMITIVE_ID * 44;
  float _198 = t0[_195].x;
  float _205 = (View_2604 * select((SV_IsFrontFace != 0), 1.0f, -1.0f)) * select(((asint(_198) & 64) != 0), -1.0f, 1.0f);
  uint _208 = View_4336 % 6;
  float _214 = select(((Material_272[0].y) < 0.009999999776482582f), 0.0f, 1.0f);
  float _223 = t0[(_195 | 2)].x;
  float _226 = t0[(_195 | 3)].x;
  float _229 = t0[((uint)(_195 + 4u))].x;
  float _235 = sqrt(((_226 * _226) + (_223 * _223)) + (_229 * _229));
  float _239 = ((Material_272[0].z) * (1.0f - _235)) + _235;
  float _242 = (_239 * ((_214 * (TEXCOORD.z - TEXCOORD.x)) + TEXCOORD.x)) + -0.5f;
  float _243 = (_239 * ((_214 * (TEXCOORD.w - TEXCOORD.y)) + TEXCOORD.y)) + -0.5f;
  float _254 = ((Material_272[0].x) * PER_INSTANCE_RANDOM) + 0.5f;
  float _261 = ((_254 + dot(float2((Material_272[1].x), (Material_272[1].y)), float2(_242, _243))) + (Material_272[2].x)) * (Material_272[2].z);
  float _262 = ((_254 + dot(float2((Material_272[1].z), (Material_272[1].w)), float2(_242, _243))) + (Material_272[2].y)) * (Material_272[2].w);
  float _275 = select(((Material_272[4].x) < 0.009999999776482582f), 0.0f, 1.0f);
  float _294 = asfloat((Material_000[0].z));
  float _295 = asfloat((Material_000[0].w));
  int _296 = (Material_000[1].z) & 15;
  int _390;
  int _391;
  int _392;
  float _393;
  float _394;
  int _395;
  int _396;
  float _449;
  float _450;
  float _647;
  float _648;
  float _649;
  float _650;
  int _1240;
  float _1241;
  float _1242;
  int _1243;
  int _1244;
  float _1301;
  float _1302;
  float _1303;
  int _1409;
  float _1410;
  float _1411;
  int _1412;
  int _1413;
  float _1470;
  float _1471;
  float _1472;
  int _1633;
  float _1634;
  float _1635;
  int _1636;
  int _1637;
  float _1694;
  float _1695;
  float _1696;
  int _1805;
  float _1806;
  float _1807;
  int _1808;
  int _1809;
  float _1866;
  float _1867;
  float _1868;
  float _2442;
  float _2443;
  float _2444;
  int _3359;
  float _3360;
  float _3361;
  int _3362;
  float _3423;
  float _3424;
  float _3425;
  float _3426;
  float _3535;
  float _3536;
  float _3537;
  float _3538;
  float _3539;
  float _3540;
  float _3541;
  float _3542;
  float _3543;
  float _3544;
  float _3545;
  float _3546;
  float _3754;
  float _3755;
  float _3756;
  if (_294 > 0.0f) {
    float _311 = asfloat((Material_000[0].x)) * ((_275 * (((Material_272[3].z) - _261) + ((Material_272[3].x) * frac(_261)))) + _261);
    float _312 = asfloat((Material_000[0].y)) * ((_275 * (((Material_272[3].w) - _262) + ((Material_272[3].y) * frac(_262)))) + _262);
    float _317 = ddx_coarse(_311) * _294;
    float _318 = ddx_coarse(_312) * _295;
    float _319 = ddy_coarse(_311) * _294;
    float _320 = ddy_coarse(_312) * _295;
    float _321 = dot(float2(_317, _318), float2(_317, _318));
    float _322 = dot(float2(_319, _320), float2(_319, _320));
    float _326 = log2(max(_321, _322));
    _44[0] = View_4304.x;
    _44[1] = View_4304.y;
    _44[2] = View_4304.z;
    _44[3] = View_4304.w;
    float _344 = float((uint)(int)(View_2664));
    int _359 = int(floor((((View_2636 - min(((_326 - log2(min(_321, _322))) * 0.5f), asfloat((Material_000[1].x)))) + (_326 * 0.5f)) + (_44[(((uint)((int)(Material_000[1].y)) >> 28) & 3)])) + frac(frac(dot(float2(((_344 * 32.665000915527344f) + SV_Position.x), ((_344 * 11.8149995803833f) + SV_Position.y)), float2(0.0671105608344078f, 0.005837149918079376f))) * 52.98291778564453f))) + (((uint)((int)(Material_000[1].y)) >> 24) & 15);
    float _362 = frac(_311) * _294;
    float _363 = frac(_312) * _295;
    int _365 = min(max(_359, 0), _296);
    int _368 = _365 & 31;
    int _369 = (uint)(uint(_362) + ((int)((Material_000[1].y) & 4095))) >> _368;
    int _372 = (uint)(uint(_363) + ((int)(((uint)((int)(Material_000[1].y)) >> 12) & 4095))) >> _368;
    uint4 _374 = t15.Load(int3(_369, _372, _365));
    _390 = _374.x;
    _391 = _374.y;
    _392 = _374.z;
    _393 = _362;
    _394 = _363;
    _395 = 1;
    _396 = select((_208 == 0), (((_369 | (Material_000[1].w)) | ((uint)(_372 << 12))) | ((uint)(min(max((_359 + 1), 0), (_296 + 1)) << 24))), -1);
  } else {
    _390 = 0;
    _391 = 0;
    _392 = 0;
    _393 = 0.0f;
    _394 = 0.0f;
    _395 = 0;
    _396 = -1;
  }
  float _402 = asfloat((Material_192[0].w));
  float _403 = abs(_402);
  float _404 = asfloat((Material_192[0].y));
  float _405 = asfloat((Material_192[0].z));
  bool _406 = (_402 > 0.0f);
  if ((uint)_390 > (uint)15) {
    float _420 = float((uint)((int)((uint)(4096u) >> (_390 & 15)))) * 0.000244140625f;
    float4 _445 = t21.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_390) >> 4) & select(_406, 255, 63)))) * _403) + _405) + (frac(_420 * _393) * _404)), (((float((uint)(int)(select(_406, (((uint)(_390) >> 12) & 255), (((uint)(_390) >> 10) & 63)))) * _403) + _405) + (frac(_394 * _420) * _404))), 0.0f);
    _449 = _445.x;
    _450 = _445.y;
  } else {
    _449 = (float((uint)((int)(((uint)((int)(Material_192[0].x)) >> 16) & 255))) * 0.003921568859368563f);
    _450 = (float((uint)((int)(((uint)((int)(Material_192[0].x)) >> 8) & 255))) * 0.003921568859368563f);
  }
  float _453 = (_449 * 2.0f) + -1.0f;
  float _454 = (_450 * 2.0f) + -1.0f;
  float _463 = (Material_272[4].y) * _453;
  float _464 = (Material_272[4].z) * _454;
  float _465 = (Material_272[4].w) * sqrt(saturate(1.0f - dot(float2(_453, _454), float2(_453, _454))));
  float _467 = rsqrt(dot(float3(_463, _464, _465), float3(_463, _464, _465)));
  float _468 = _463 * _467;
  float _469 = _464 * _467;
  float _471 = (_465 * _467) + 1.0f;
  float4 _480 = t5.SampleBias(s3, float2(((Material_272[5].x) * TEXCOORD.x), ((Material_272[5].x) * TEXCOORD.y)), View_2636, int2(0, 0));
  float _485 = (_480.x * 2.0f) + -1.0f;
  float _486 = (_480.y * 2.0f) + -1.0f;
  float _490 = sqrt(saturate(1.0f - dot(float2(_485, _486), float2(_485, _486))));
  float _499 = ((Material_272[5].y) * (1.0f - _490)) + _490;
  float _500 = -0.0f - (_485 - ((Material_272[5].y) * _485));
  float _501 = -0.0f - (_486 - ((Material_272[5].y) * _486));
  float _502 = dot(float3(_468, _469, _471), float3(_500, _501, _499));
  float _507 = (_502 * _468) - (_471 * _500);
  float _508 = (_502 * _469) - (_471 * _501);
  float _510 = (_502 - _499) * _471;
  float _512 = rsqrt(dot(float3(_507, _508, _510), float3(_507, _508, _510)));
  float _513 = _507 * _512;
  float _514 = _508 * _512;
  float _515 = _510 * _512;
  float _517 = rsqrt(dot(float3(_513, _514, _515), float3(_513, _514, _515)));
  float _518 = _513 * _517;
  float _519 = _514 * _517;
  float _520 = _515 * _517;
  float _527 = ((Material_272[5].z) * TEXCOORD.x) + (Material_272[6].x);
  float _528 = ((Material_272[5].z) * TEXCOORD.y) + (Material_272[6].y);
  float4 _533 = t6.SampleBias(s4, float2(_527, _528), View_2636, int2(0, 0));
  float _538 = (_533.x * 2.0f) + -1.0f;
  float _539 = (_533.y * 2.0f) + -1.0f;
  float _543 = sqrt(saturate(1.0f - dot(float2(_538, _539), float2(_538, _539))));
  float4 _554 = t7.SampleBias(s5, float2(_527, _528), View_2636, int2(0, 0));
  uint _556 = _195 + 37u;
  float _559 = t0[_556].z;
  float _560 = t0[_556].w;
  float _563 = saturate(max(_559, _560) * 0.10000000149011612f);
  float _569 = select((_563 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_563) * (Material_272[6].w)));
  float _572 = _205 * TEXCOORD.z;
  float _573 = dot(float3((_205 * TEXCOORD.x), (_205 * TEXCOORD.y), _572), float3(0.0f, 0.0f, 1.0f));
  float _579 = saturate(max(((_573 + 0.5f) * 0.5f), ((_573 + -0.5f) * 2.0f)));
  float _592 = asfloat((Material_192[1].w));
  float _593 = abs(_592);
  float _594 = asfloat((Material_192[1].y));
  float _595 = asfloat((Material_192[1].z));
  bool _596 = (_592 > 0.0f);
  if ((uint)_391 > (uint)15) {
    float _616 = float((uint)((int)((uint)(4096u) >> (_391 & 15)))) * 0.000244140625f;
    float4 _641 = t22.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_391) >> 4) & select(_596, 255, 63)))) * _593) + _595) + (frac(_616 * _393) * _594)), (((float((uint)(int)(select(_596, (((uint)(_391) >> 12) & 255), (((uint)(_391) >> 10) & 63)))) * _593) + _595) + (frac(_616 * _394) * _594))), 0.0f);
    _647 = _641.x;
    _648 = _641.y;
    _649 = _641.z;
    _650 = _641.w;
  } else {
    _647 = (float((uint)((int)(((uint)((int)(Material_192[1].x)) >> 16) & 255))) * 0.003921568859368563f);
    _648 = (float((uint)((int)(((uint)((int)(Material_192[1].x)) >> 8) & 255))) * 0.003921568859368563f);
    _649 = (float((uint)((int)((Material_192[1].x) & 255))) * 0.003921568859368563f);
    _650 = (float((uint)((int)((uint)((int)(Material_192[1].x)) >> 24))) * 0.003921568859368563f);
  }
  float _656 = dot(float4(_647, _648, _649, _650), float4((Material_272[8].x), (Material_272[8].y), (Material_272[8].z), (Material_272[8].w)));
  float _662 = dot(float4(_647, _648, _649, _650), float4((Material_272[9].x), (Material_272[9].y), (Material_272[9].z), (Material_272[9].w)));
  float _674 = dot(float4(_647, _648, _649, _650), float4((Material_272[11].x), (Material_272[11].y), (Material_272[11].z), (Material_272[11].w)));
  float _686 = saturate(((1.0f - (Material_272[12].y)) * select((_656 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_656) * (Material_272[12].x)))) + (Material_272[12].y));
  float _693 = ((Material_272[12].w) * (MaterialCollection0_000.FMaterialCollection0Constants_000[4].x)) + 20.0f;
  float _696 = min((_693 * 0.25f), _693) + -0.009999999776482582f;
  float _703 = saturate(((TEXCOORD.y - _696) + (Material_272[13].x)) / (_693 - _696));
  float _712 = saturate(((saturate(_569) * _686) * (Material_272[12].z)) * (1.0f - ((_703 * _703) * (3.0f - (_703 * 2.0f)))));
  float _719 = saturate(select((_712 <= 2.980232949312267e-08f), 0.0f, (pow(_712, 0.20000000298023224f))) - _554.x);
  float _723 = saturate((_686 * _569) * max(select((_579 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_579) * (Material_272[7].x))), _719));
  float _727 = ((_554.x + -1.0f) + _723) / max(_723, 0.20000000298023224f);
  bool _729 = (_727 <= 2.980232949312267e-08f);
  float _730 = log2(_727);
  float _737 = max(saturate(select(_729, -0.05000000074505806f, ((exp2(_730 * (Material_272[13].y)) * 1.0999999046325684f) + -0.05000000074505806f))), _719);
  float _746 = select(_729, 0.0f, exp2(_730 * (Material_272[13].z)));
  float _754 = (_746 * ((_737 * (_538 - ((Material_272[6].z) * _538))) - _518)) + _518;
  float _755 = (_746 * ((_737 * (_539 - ((Material_272[6].z) * _539))) - _519)) + _519;
  float _756 = (_746 * ((1.0f - _520) + (_737 * ((_543 + -1.0f) + ((Material_272[6].z) * (1.0f - _543)))))) + _520;
  float _765 = saturate(select((_686 <= 2.980232949312267e-08f), -0.10000000149011612f, (((pow(_686, 16.0f)) * 1.2000000476837158f) + -0.10000000149011612f))) * 0.800000011920929f;
  float _773 = dot(float3(_192, _193, _194), float3((_205 * TEXCOORD11_centroid.x), (_205 * TEXCOORD11_centroid.y), (_205 * TEXCOORD11_centroid.z)));
  float _778 = select((_773 <= 2.980232949312267e-08f), 0.0f, (pow(_773, 0.5f)));
  float _800 = select((abs((Material_272[13].w) - (Material_272[14].x)) > 9.999999747378752e-06f), select(((Material_272[13].w) >= (Material_272[14].x)), 1.0f, (1.0f - saturate(saturate((View_2616 - (Material_272[14].x)) * (Material_272[14].y))))), 0.0f) * saturate(saturate((View_2616 - (Material_272[13].w)) * 1.4285714626312256f));
  float _802 = 1.0f - (_800 * _800);
  float _803 = _802 * 1.2000000476837158f;
  float _805 = saturate(1.0989999771118164f - _803);
  float _814 = saturate((((_778 + 1.2000000476837158f) - _805) - (_802 * 2.4000000953674316f)) / (saturate(1.1010000705718994f - _803) - _805));
  float _818 = (_814 * _814) * (3.0f - (_814 * 2.0f));
  float _822 = _754 - ((_765 * _754) * _818);
  float _823 = _755 - ((_765 * _755) * _818);
  float _825 = (_756 + 1.0f) + ((_765 * (1.0f - _756)) * _818);
  float _826 = TEXCOORD.w * 0.009999999776482582f;
  float _827 = TEXCOORD.x * 0.009999999776482582f;
  float _829 = _826 * (Material_272[14].z);
  float _830 = _827 * (Material_272[14].z);
  float4 _836 = t8.SampleBias(s6, float2((_829 + 0.004999999888241291f), _830), View_2636, int2(0, 0));
  float4 _842 = t8.SampleBias(s6, float2(_829, _830), View_2636, int2(0, 0));
  float _847 = dot(float4(_842.x, _842.y, _842.z, _842.w), float4(0.0f, 0.0f, 0.0f, 1.0f));
  float _848 = dot(float4(_836.x, _836.y, _836.z, _836.w), float4(0.0f, 0.0f, 0.0f, 1.0f)) - _847;
  float4 _854 = t8.SampleBias(s6, float2(_829, (_830 + 0.004999999888241291f)), View_2636, int2(0, 0));
  float _860 = dot(float4(_854.x, _854.y, _854.z, _854.w), float4(0.0f, 0.0f, 0.0f, 1.0f)) - _847;
  float _861 = TEXCOORD.z * 0.009999999776482582f;
  float _864 = _861 * (Material_272[14].z);
  float _865 = _826 * (Material_272[14].z);
  float4 _871 = t8.SampleBias(s6, float2((_864 + 0.004999999888241291f), _865), View_2636, int2(0, 0));
  float4 _877 = t8.SampleBias(s6, float2(_864, _865), View_2636, int2(0, 0));
  float _882 = dot(float4(_877.x, _877.y, _877.z, _877.w), float4(0.0f, 0.0f, 0.0f, 1.0f));
  float4 _888 = t8.SampleBias(s6, float2(_864, (_865 + 0.004999999888241291f)), View_2636, int2(0, 0));
  float _894 = abs(TEXCOORD.w);
  float _897 = select((_894 <= 2.980232949312267e-08f), 0.0f, (_894 * _894));
  float _904 = (_897 * ((_848 - dot(float4(_871.x, _871.y, _871.z, _871.w), float4(0.0f, 0.0f, 0.0f, 1.0f))) + _882)) - _848;
  float _905 = (_897 * ((_882 + _860) - dot(float4(_888.x, _888.y, _888.z, _888.w), float4(0.0f, 0.0f, 0.0f, 1.0f)))) - _860;
  float _908 = _861 * (Material_272[14].z);
  float _909 = _827 * (Material_272[14].z);
  float4 _915 = t8.SampleBias(s6, float2((_908 + 0.004999999888241291f), _909), View_2636, int2(0, 0));
  float4 _921 = t8.SampleBias(s6, float2(_908, _909), View_2636, int2(0, 0));
  float _926 = dot(float4(_921.x, _921.y, _921.z, _921.w), float4(0.0f, 0.0f, 0.0f, 1.0f));
  float4 _932 = t8.SampleBias(s6, float2(_908, (_909 + 0.004999999888241291f)), View_2636, int2(0, 0));
  float _938 = abs(TEXCOORD.z);
  float _941 = select((_938 <= 2.980232949312267e-08f), 0.0f, (_938 * _938));
  float _952 = (_897 * (_877.w - _842.w)) + _842.w;
  float _955 = (_941 * (_921.w - _952)) + _952;
  float _962 = saturate(0.75f - (Material_272[14].w));
  float _971 = saturate((((min(max(_955, 0.009999999776482582f), 0.9900000095367432f) + -1.0f) - _962) + ((1.0f - (Material_272[14].w)) * 2.0f)) / (saturate(1.25f - (Material_272[14].w)) - _962));
  float _975 = (_971 * _971) * (3.0f - (_971 * 2.0f));
  float _977 = -0.0f - (((_941 * (_926 - (_904 + dot(float4(_915.x, _915.y, _915.z, _915.w), float4(0.0f, 0.0f, 0.0f, 1.0f))))) + _904) * _975);
  float _979 = -0.0f - (((_941 * (_926 - (_905 + dot(float4(_932.x, _932.y, _932.z, _932.w), float4(0.0f, 0.0f, 0.0f, 1.0f))))) + _905) * _975);
  float _980 = dot(float3(_822, _823, _825), float3(_977, _979, 1.0f));
  float _986 = (_980 * _822) - (_825 * _977);
  float _987 = (_980 * _823) - (_825 * _979);
  float _988 = (_980 * _825) - _825;
  float _990 = rsqrt(dot(float3(_986, _987, _988), float3(_986, _987, _988)));
  float _991 = _986 * _990;
  float _992 = _987 * _990;
  float _993 = _988 * _990;
  float _1008 = (((Material_272[16].x) * 0.009999999776482582f) * ((Material_272[15].x) + TEXCOORD.z)) * (Material_272[16].w);
  float _1011 = (((Material_272[16].y) * 0.009999999776482582f) * ((Material_272[15].y) + TEXCOORD.w)) * (Material_272[16].w);
  float _1014 = (((Material_272[16].z) * 0.009999999776482582f) * ((Material_272[15].z) + TEXCOORD.x)) * (Material_272[16].w);
  float _1020 = (View_2616 * 0.179299995303154f) * (Material_272[17].x);
  float4 _1030 = t14.Sample(s11, float3(((_1020 + _1008) * (Material_272[17].y)), ((_1020 + _1011) * (Material_272[17].y)), ((_1020 + _1014) * (Material_272[17].y))));
  float _1055 = (saturate(saturate((View_2616 - (Material_272[17].z)) * 5.0f)) * 2.0f) * select((abs((Material_272[17].z) - (Material_272[17].w)) > 9.999999747378752e-06f), select(((Material_272[17].z) >= (Material_272[17].w)), 1.0f, (1.0f - saturate(saturate((View_2616 - (Material_272[17].w)) * 3.7037036418914795f)))), 0.0f);
  float _1057 = saturate(_1055 + -1.0f);
  float _1061 = (_1057 * (_1030.x + -0.5f)) * (Material_272[18].x);
  _72[0] = (_1061 + _1008);
  _72[1] = (_1061 + _1011);
  _72[2] = (_1061 + _1014);
  float _1072 = abs(TEXCOORD.y);
  _71[0] = _1072;
  _71[1] = _938;
  _71[2] = _894;
  bool _1075 = (bool)(_1072 > _938) && (bool)(_1072 > _894);
  bool _1076 = (_938 > _894);
  int _1081 = select(_1075, 0, select(_1076, 1, 2));
  int _1082 = select(_1075, 1, select(_1076, 2, 0));
  int _1083 = select(_1075, 2, (((int)(uint)(_1076)) ^ 1));
  bool _1086 = (bool)(_1072 < _938) && (bool)(_1072 < _894);
  bool _1087 = (_938 <= _894);
  float _1110 = (Material_272[18].y) * 0.125f;
  float _1116 = exp2(log2(min(max((((_71[(select(_1086, 3, select(_1087, 2, 1)) - _1081)]) + -0.5773000121116638f) * 2.365744113922119f), 0.0f), 1.0f)) * _1110);
  float _1118 = _72[_1082];
  float _1120 = _72[_1083];
  float _1122 = _72[(select(_1086, 2, select(_1087, 1, 3)) - _1082)];
  float _1124 = _72[(select(_1086, 1, (((int)(uint)(_1087)) | 2)) - _1083)];
  float _1130 = saturate(_1055 + -0.10000000149011612f);
  float _1133 = select((max(_1130, _1057) < 0.009999999776482582f), 2.0f, 0.0f);
  float _1136 = _1133 + View_2636;
  float _1147 = asfloat((Material_000[2].z));
  float _1148 = asfloat((Material_000[2].w));
  int _1149 = (Material_000[3].z) & 15;
  if (_1147 > 0.0f) {
    float _1162 = asfloat((Material_000[2].x)) * frac(_1118);
    float _1163 = asfloat((Material_000[2].y)) * frac(_1120);
    float _1168 = ddx_coarse(_1162) * _1147;
    float _1169 = ddx_coarse(_1163) * _1148;
    float _1170 = ddy_coarse(_1162) * _1147;
    float _1171 = ddy_coarse(_1163) * _1148;
    float _1172 = dot(float2(_1168, _1169), float2(_1168, _1169));
    float _1173 = dot(float2(_1170, _1171), float2(_1170, _1171));
    float _1177 = log2(max(_1172, _1173));
    _45[0] = View_4304.x;
    _45[1] = View_4304.y;
    _45[2] = View_4304.z;
    _45[3] = View_4304.w;
    float _1195 = float((uint)(int)(View_2664));
    int _1210 = int(floor((((_1136 - min(((_1177 - log2(min(_1172, _1173))) * 0.5f), asfloat((Material_000[3].x)))) + (_1177 * 0.5f)) + (_45[(((uint)((int)(Material_000[3].y)) >> 28) & 3)])) + frac(frac(dot(float2(((_1195 * 32.665000915527344f) + SV_Position.x), ((_1195 * 11.8149995803833f) + SV_Position.y)), float2(0.0671105608344078f, 0.005837149918079376f))) * 52.98291778564453f))) + (((uint)((int)(Material_000[3].y)) >> 24) & 15);
    float _1213 = frac(_1162) * _1147;
    float _1214 = frac(_1163) * _1148;
    int _1216 = min(max(_1210, 0), _1149);
    int _1219 = _1216 & 31;
    int _1220 = (uint)(uint(_1213) + ((int)((Material_000[3].y) & 4095))) >> _1219;
    int _1223 = (uint)(uint(_1214) + ((int)(((uint)((int)(Material_000[3].y)) >> 12) & 4095))) >> _1219;
    uint4 _1225 = t16.Load(int3(_1220, _1223, _1216));
    _1240 = _1225.x;
    _1241 = _1213;
    _1242 = _1214;
    _1243 = (_395 + 1);
    _1244 = select((_395 == _208), (((_1220 | (Material_000[3].w)) | ((uint)(_1223 << 12))) | ((uint)(min(max((_1210 + 1), 0), (_1149 + 1)) << 24))), _396);
  } else {
    _1240 = 0;
    _1241 = 0.0f;
    _1242 = 0.0f;
    _1243 = _395;
    _1244 = _396;
  }
  float _1250 = asfloat((Material_192[2].w));
  float _1251 = abs(_1250);
  float _1252 = asfloat((Material_192[2].y));
  float _1253 = asfloat((Material_192[2].z));
  bool _1254 = (_1250 > 0.0f);
  if ((uint)_1240 > (uint)15) {
    float _1271 = float((uint)((int)((uint)(4096u) >> (_1240 & 15)))) * 0.000244140625f;
    float4 _1296 = t23.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_1240) >> 4) & select(_1254, 255, 63)))) * _1251) + _1253) + (frac(_1271 * _1241) * _1252)), (((float((uint)(int)(select(_1254, (((uint)(_1240) >> 12) & 255), (((uint)(_1240) >> 10) & 63)))) * _1251) + _1253) + (frac(_1271 * _1242) * _1252))), 0.0f);
    _1301 = _1296.x;
    _1302 = _1296.y;
    _1303 = _1296.w;
  } else {
    _1301 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 16) & 255))) * 0.003921568859368563f);
    _1302 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 8) & 255))) * 0.003921568859368563f);
    _1303 = (float((uint)((int)((uint)((int)(Material_192[2].x)) >> 24))) * 0.003921568859368563f);
  }
  float _1316 = asfloat((Material_000[4].z));
  float _1317 = asfloat((Material_000[4].w));
  int _1318 = (Material_000[5].z) & 15;
  if (_1316 > 0.0f) {
    float _1331 = asfloat((Material_000[4].x)) * frac(_1122);
    float _1332 = asfloat((Material_000[4].y)) * frac(_1124);
    float _1337 = ddx_coarse(_1331) * _1316;
    float _1338 = ddx_coarse(_1332) * _1317;
    float _1339 = ddy_coarse(_1331) * _1316;
    float _1340 = ddy_coarse(_1332) * _1317;
    float _1341 = dot(float2(_1337, _1338), float2(_1337, _1338));
    float _1342 = dot(float2(_1339, _1340), float2(_1339, _1340));
    float _1346 = log2(max(_1341, _1342));
    _46[0] = View_4304.x;
    _46[1] = View_4304.y;
    _46[2] = View_4304.z;
    _46[3] = View_4304.w;
    float _1364 = float((uint)(int)(View_2664));
    int _1379 = int(floor((((_1136 - min(((_1346 - log2(min(_1341, _1342))) * 0.5f), asfloat((Material_000[5].x)))) + (_1346 * 0.5f)) + (_46[(((uint)((int)(Material_000[5].y)) >> 28) & 3)])) + frac(frac(dot(float2(((_1364 * 32.665000915527344f) + SV_Position.x), ((_1364 * 11.8149995803833f) + SV_Position.y)), float2(0.0671105608344078f, 0.005837149918079376f))) * 52.98291778564453f))) + (((uint)((int)(Material_000[5].y)) >> 24) & 15);
    float _1382 = frac(_1331) * _1316;
    float _1383 = frac(_1332) * _1317;
    int _1385 = min(max(_1379, 0), _1318);
    int _1388 = _1385 & 31;
    int _1389 = (uint)(uint(_1382) + ((int)((Material_000[5].y) & 4095))) >> _1388;
    int _1392 = (uint)(uint(_1383) + ((int)(((uint)((int)(Material_000[5].y)) >> 12) & 4095))) >> _1388;
    uint4 _1394 = t17.Load(int3(_1389, _1392, _1385));
    _1409 = _1394.x;
    _1410 = _1382;
    _1411 = _1383;
    _1412 = (_1243 + 1);
    _1413 = select((_1243 == _208), (((_1389 | (Material_000[5].w)) | ((uint)(_1392 << 12))) | ((uint)(min(max((_1379 + 1), 0), (_1318 + 1)) << 24))), _1244);
  } else {
    _1409 = 0;
    _1410 = 0.0f;
    _1411 = 0.0f;
    _1412 = _1243;
    _1413 = _1244;
  }
  float _1419 = asfloat((Material_192[2].w));
  float _1420 = abs(_1419);
  float _1421 = asfloat((Material_192[2].y));
  float _1422 = asfloat((Material_192[2].z));
  bool _1423 = (_1419 > 0.0f);
  if ((uint)_1409 > (uint)15) {
    float _1440 = float((uint)((int)((uint)(4096u) >> (_1409 & 15)))) * 0.000244140625f;
    float4 _1465 = t23.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_1409) >> 4) & select(_1423, 255, 63)))) * _1420) + _1422) + (frac(_1440 * _1410) * _1421)), (((float((uint)(int)(select(_1423, (((uint)(_1409) >> 12) & 255), (((uint)(_1409) >> 10) & 63)))) * _1420) + _1422) + (frac(_1440 * _1411) * _1421))), 0.0f);
    _1470 = _1465.x;
    _1471 = _1465.y;
    _1472 = _1465.w;
  } else {
    _1470 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 16) & 255))) * 0.003921568859368563f);
    _1471 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 8) & 255))) * 0.003921568859368563f);
    _1472 = (float((uint)((int)((uint)((int)(Material_192[2].x)) >> 24))) * 0.003921568859368563f);
  }
  float _1473 = saturate(_1116 / (_1116 + exp2(log2(min(max((((_71[_1081]) + -0.5773000121116638f) * 2.365744113922119f), 0.0f), 1.0f)) * _1110)));
  float _1480 = (_1473 * (_1472 - _1303)) + _1303;
  float _1491 = select((_1480 <= 2.980232949312267e-08f), 0.0f, (pow(_1480, 0.699999988079071f)));
  float _1503 = sin(((Material_272[17].x) * 6.2831854820251465f) * (View_2616 + _1030.z));
  float _1510 = abs(_1503);
  float _1522 = (-0.009999999776482582f - ((1.0f - _1057) * 0.23999999463558197f)) + (((select((_1510 <= 2.980232949312267e-08f), 0.0f, (pow(_1510, 0.800000011920929f))) * _1057) * float((int)(((int)(uint)((bool)(_1503 > 0.0f))) - ((int)(uint)((bool)(_1503 < 0.0f)))))) * (Material_272[18].z));
  float _1523 = ((((_1301 + -0.5f) + (_1473 * (_1470 - _1301))) * 2.0f) * _1491) * _1522;
  float _1524 = ((((_1302 + -0.5f) + (_1473 * (_1471 - _1302))) * 2.0f) * _1491) * _1522;
  float _1540 = asfloat((Material_000[6].z));
  float _1541 = asfloat((Material_000[6].w));
  int _1542 = (Material_000[7].z) & 15;
  if (_1540 > 0.0f) {
    float _1555 = asfloat((Material_000[6].x)) * (frac(_1523 + _1118) + 1.0f);
    float _1556 = asfloat((Material_000[6].y)) * frac(_1524 + _1120);
    float _1561 = ddx_coarse(_1555) * _1540;
    float _1562 = ddx_coarse(_1556) * _1541;
    float _1563 = ddy_coarse(_1555) * _1540;
    float _1564 = ddy_coarse(_1556) * _1541;
    float _1565 = dot(float2(_1561, _1562), float2(_1561, _1562));
    float _1566 = dot(float2(_1563, _1564), float2(_1563, _1564));
    float _1570 = log2(max(_1565, _1566));
    _47[0] = View_4304.x;
    _47[1] = View_4304.y;
    _47[2] = View_4304.z;
    _47[3] = View_4304.w;
    float _1588 = float((uint)(int)(View_2664));
    int _1603 = int(floor((((_1136 - min(((_1570 - log2(min(_1565, _1566))) * 0.5f), asfloat((Material_000[7].x)))) + (_1570 * 0.5f)) + (_47[(((uint)((int)(Material_000[7].y)) >> 28) & 3)])) + frac(frac(dot(float2(((_1588 * 32.665000915527344f) + SV_Position.x), ((_1588 * 11.8149995803833f) + SV_Position.y)), float2(0.0671105608344078f, 0.005837149918079376f))) * 52.98291778564453f))) + (((uint)((int)(Material_000[7].y)) >> 24) & 15);
    float _1606 = frac(_1555) * _1540;
    float _1607 = frac(_1556) * _1541;
    int _1609 = min(max(_1603, 0), _1542);
    int _1612 = _1609 & 31;
    int _1613 = (uint)(uint(_1606) + ((int)((Material_000[7].y) & 4095))) >> _1612;
    int _1616 = (uint)(uint(_1607) + ((int)(((uint)((int)(Material_000[7].y)) >> 12) & 4095))) >> _1612;
    uint4 _1618 = t18.Load(int3(_1613, _1616, _1609));
    _1633 = _1618.x;
    _1634 = _1606;
    _1635 = _1607;
    _1636 = (_1412 + 1);
    _1637 = select((_1412 == _208), (((_1613 | (Material_000[7].w)) | ((uint)(_1616 << 12))) | ((uint)(min(max((_1603 + 1), 0), (_1542 + 1)) << 24))), _1413);
  } else {
    _1633 = 0;
    _1634 = 0.0f;
    _1635 = 0.0f;
    _1636 = _1412;
    _1637 = _1413;
  }
  float _1643 = asfloat((Material_192[2].w));
  float _1644 = abs(_1643);
  float _1645 = asfloat((Material_192[2].y));
  float _1646 = asfloat((Material_192[2].z));
  bool _1647 = (_1643 > 0.0f);
  if ((uint)_1633 > (uint)15) {
    float _1664 = float((uint)((int)((uint)(4096u) >> (_1633 & 15)))) * 0.000244140625f;
    float4 _1689 = t23.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_1633) >> 4) & select(_1647, 255, 63)))) * _1644) + _1646) + (frac(_1664 * _1634) * _1645)), (((float((uint)(int)(select(_1647, (((uint)(_1633) >> 12) & 255), (((uint)(_1633) >> 10) & 63)))) * _1644) + _1646) + (frac(_1664 * _1635) * _1645))), 0.0f);
    _1694 = _1689.x;
    _1695 = _1689.y;
    _1696 = _1689.w;
  } else {
    _1694 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 16) & 255))) * 0.003921568859368563f);
    _1695 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 8) & 255))) * 0.003921568859368563f);
    _1696 = (float((uint)((int)((uint)((int)(Material_192[2].x)) >> 24))) * 0.003921568859368563f);
  }
  float _1712 = asfloat((Material_000[8].z));
  float _1713 = asfloat((Material_000[8].w));
  int _1714 = (Material_000[9].z) & 15;
  if (_1712 > 0.0f) {
    float _1727 = asfloat((Material_000[8].x)) * (frac(_1523 + _1122) + 1.0f);
    float _1728 = asfloat((Material_000[8].y)) * frac(_1524 + _1124);
    float _1733 = ddx_coarse(_1727) * _1712;
    float _1734 = ddx_coarse(_1728) * _1713;
    float _1735 = ddy_coarse(_1727) * _1712;
    float _1736 = ddy_coarse(_1728) * _1713;
    float _1737 = dot(float2(_1733, _1734), float2(_1733, _1734));
    float _1738 = dot(float2(_1735, _1736), float2(_1735, _1736));
    float _1742 = log2(max(_1737, _1738));
    _48[0] = View_4304.x;
    _48[1] = View_4304.y;
    _48[2] = View_4304.z;
    _48[3] = View_4304.w;
    float _1760 = float((uint)(int)(View_2664));
    int _1775 = int(floor((((_1136 - min(((_1742 - log2(min(_1737, _1738))) * 0.5f), asfloat((Material_000[9].x)))) + (_1742 * 0.5f)) + (_48[(((uint)((int)(Material_000[9].y)) >> 28) & 3)])) + frac(frac(dot(float2(((_1760 * 32.665000915527344f) + SV_Position.x), ((_1760 * 11.8149995803833f) + SV_Position.y)), float2(0.0671105608344078f, 0.005837149918079376f))) * 52.98291778564453f))) + (((uint)((int)(Material_000[9].y)) >> 24) & 15);
    float _1778 = frac(_1727) * _1712;
    float _1779 = frac(_1728) * _1713;
    int _1781 = min(max(_1775, 0), _1714);
    int _1784 = _1781 & 31;
    int _1785 = (uint)(uint(_1778) + ((int)((Material_000[9].y) & 4095))) >> _1784;
    int _1788 = (uint)(uint(_1779) + ((int)(((uint)((int)(Material_000[9].y)) >> 12) & 4095))) >> _1784;
    uint4 _1790 = t19.Load(int3(_1785, _1788, _1781));
    _1805 = _1790.x;
    _1806 = _1778;
    _1807 = _1779;
    _1808 = ((uint)(_1636 + 1u));
    _1809 = select((_1636 == _208), (((_1785 | (Material_000[9].w)) | ((uint)(_1788 << 12))) | ((uint)(min(max((_1775 + 1), 0), (_1714 + 1)) << 24))), _1637);
  } else {
    _1805 = 0;
    _1806 = 0.0f;
    _1807 = 0.0f;
    _1808 = _1636;
    _1809 = _1637;
  }
  float _1815 = asfloat((Material_192[2].w));
  float _1816 = abs(_1815);
  float _1817 = asfloat((Material_192[2].y));
  float _1818 = asfloat((Material_192[2].z));
  bool _1819 = (_1815 > 0.0f);
  if ((uint)_1805 > (uint)15) {
    float _1836 = float((uint)((int)((uint)(4096u) >> (_1805 & 15)))) * 0.000244140625f;
    float4 _1861 = t23.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_1805) >> 4) & select(_1819, 255, 63)))) * _1816) + _1818) + (frac(_1836 * _1806) * _1817)), (((float((uint)(int)(select(_1819, (((uint)(_1805) >> 12) & 255), (((uint)(_1805) >> 10) & 63)))) * _1816) + _1818) + (frac(_1836 * _1807) * _1817))), 0.0f);
    _1866 = _1861.x;
    _1867 = _1861.y;
    _1868 = _1861.w;
  } else {
    _1866 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 16) & 255))) * 0.003921568859368563f);
    _1867 = (float((uint)((int)(((uint)((int)(Material_192[2].x)) >> 8) & 255))) * 0.003921568859368563f);
    _1868 = (float((uint)((int)((uint)((int)(Material_192[2].x)) >> 24))) * 0.003921568859368563f);
  }
  float _1875 = ((_1868 - _1696) * _1473) + _1696;
  float _1880 = ((_1694 + -0.5f) + ((_1866 - _1694) * _1473)) * 2.0f;
  float _1881 = ((_1695 + -0.5f) + ((_1867 - _1695) * _1473)) * 2.0f;
  float _1882 = -0.0f - TEXCOORD.y;
  float _1886 = sqrt((TEXCOORD.z * TEXCOORD.z) + (TEXCOORD.y * TEXCOORD.y));
  bool _1887 = (_1886 >= 0.009999999776482582f);
  bool _1892 = (abs(_1886 + -0.009999999776482582f) > 9.999999747378752e-06f);
  float _1893 = select(_1892, select(_1887, TEXCOORD.z, 1.0f), TEXCOORD.z);
  float _1894 = select(_1892, select(_1887, _1882, 0.0f), _1882);
  float _1896 = rsqrt(dot(float3(_1893, _1894, 0.0f), float3(_1893, _1894, 0.0f)));
  float _1897 = _1893 * _1896;
  float _1898 = _1894 * _1896;
  float _1900 = -0.0f - (TEXCOORD.w * _1898);
  float _1901 = _1897 * TEXCOORD.w;
  float _1904 = (_1898 * TEXCOORD.y) - (_1897 * TEXCOORD.z);
  float _1906 = rsqrt(dot(float3(_1900, _1901, _1904), float3(_1900, _1901, _1904)));
  float _1909 = _1906 * _1880;
  float _1914 = TEXCOORD.w - (_1909 * _1904);
  float _1917 = (TEXCOORD.y - ((_1880 * _1900) * _1906)) + (_1897 * _1881);
  float _1918 = (TEXCOORD.z - (_1909 * _1901)) + (_1898 * _1881);
  float _1920 = rsqrt(dot(float3(_1917, _1918, _1914), float3(_1917, _1918, _1914)));
  float _1921 = _1917 * _1920;
  float _1922 = _1918 * _1920;
  float _1923 = _1914 * _1920;
  float _1926 = mad(TEXCOORD10_centroid.z, _1923, mad(TEXCOORD10_centroid.y, _1922, (_1921 * TEXCOORD10_centroid.x)));
  float _1929 = mad(_147, _1923, mad(_146, _1922, (_1921 * _145)));
  float _1932 = mad(TEXCOORD11_centroid.z, _1923, mad(TEXCOORD11_centroid.y, _1922, (_1921 * TEXCOORD11_centroid.x)));
  float _1937 = saturate(((_1130 + -1.0f) + _1875) / max(_1130, 0.20000000298023224f));
  float _1942 = select((_1937 <= 2.980232949312267e-08f), 0.0f, (pow(_1937, 1.5f)));
  float _1949 = 1.0f - ((lerp(_1942, 1.0f, 9.0f)) * (Material_272[18].w));
  float _1954 = _1926 - (_1949 * _1926);
  float _1955 = _1929 - (_1949 * _1929);
  float _1956 = (_1949 * (1.0f - _1932)) + _1932;
  float _1958 = rsqrt(dot(float3(_1954, _1955, _1956), float3(_1954, _1955, _1956)));
  float _1974 = (((((_1954 * _1958) - _991) * _1937) + _991) * View_2544.w) + View_2544.x;
  float _1975 = (((((_1955 * _1958) - _992) * _1937) + _992) * View_2544.w) + View_2544.y;
  float _1976 = (((((_1956 * _1958) - _993) * _1937) + _993) * View_2544.w) + View_2544.z;
  float _1978 = rsqrt(dot(float3(_1974, _1975, _1976), float3(_1974, _1975, _1976)));
  float _1979 = _1974 * _1978;
  float _1980 = _1975 * _1978;
  float _1981 = _1976 * _1978;
  float _1984 = mad(_1981, TEXCOORD11_centroid.x, mad(_1980, _145, (_1979 * TEXCOORD10_centroid.x)));
  float _1987 = mad(_1981, TEXCOORD11_centroid.y, mad(_1980, _146, (_1979 * TEXCOORD10_centroid.y)));
  float _1990 = mad(_1981, TEXCOORD11_centroid.z, mad(_1980, _147, (_1979 * TEXCOORD10_centroid.z)));
  float _1992 = rsqrt(dot(float3(_1984, _1987, _1990), float3(_1984, _1987, _1990)));
  float _1994 = (_1984 * _205) * _1992;
  float _1996 = (_1987 * _205) * _1992;
  float _1998 = (_1990 * _205) * _1992;
  float _1999 = TEXCOORD.x * 1.5f;
  float _2000 = TEXCOORD.y * 1.5f;
  float _2001 = TEXCOORD.y * 1.0499999523162842f;
  float _2002 = PER_INSTANCE_RANDOM * 0.009999999776482582f;
  float _2007 = _1999 + _2002;
  float4 _2014 = t8.SampleLevel(s6, float2(_2007, ((_2000 + _2002) + frac(View_2616 * 0.25f))), View_2636);
  float _2019 = _2007 + (_2014.x * 0.25f);
  float _2021 = (_2001 + _2002) + (_2014.y * 0.25f);
  float4 _2023 = t8.SampleLevel(s6, float2(_2019, _2021), (View_2636 + -10.0f));
  float4 _2025 = t8.SampleLevel(s6, float2(_2019, _2021), View_2636);
  float _2027 = max(_2023.x, _2025.x);
  float _2032 = select((_2027 <= 2.980232949312267e-08f), 0.0f, (pow(_2027, 1.5f)));
  float4 _2035 = t9.SampleLevel(s7, float2(_1999, _2001), View_2636);
  float _2045 = saturate(0.5f - (Material_272[19].x));
  float _2048 = (1.0f - (Material_272[19].x)) * 2.0f;
  float _2055 = saturate(((select((_2032 <= 2.980232949312267e-08f), -1.0f, ((pow(_2032, 1.5f)) + -1.0f)) - _2045) + _2048) / (saturate(1.5f - (Material_272[19].x)) - _2045));
  float _2061 = saturate(0.75f - (Material_272[19].x));
  float _2069 = saturate((((_2035.x + -1.0f) - _2061) + _2048) / (saturate(1.25f - (Material_272[19].x)) - _2061));
  float _2073 = (_2069 * _2069) * (3.0f - (_2069 * 2.0f));
  float _2076 = select((_2073 <= 2.980232949312267e-08f), 0.0f, (_2073 * _2073));
  float _2077 = ((_2055 * _2055) * (3.0f - (_2055 * 2.0f))) * _2076;
  float _2078 = _2077 * 2.0f;
  float _2079 = saturate(_2078);
  float _2080 = _2079 * 1.2749000787734985f;
  float _2081 = _2079 * 1.5364580154418945f;
  float _2082 = _2079 * 0.010167480446398258f;
  float _2086 = saturate(_2078 + -1.0f);
  float _2094 = (_2081 + 0.46354201436042786f) + ((2.5364580154418945f - _2081) * _2086);
  float _2100 = _2079 * 0.07682300359010696f;
  float _2108 = _2079 * 0.3642200827598572f;
  float _2117 = ((((_2080 + 0.3698207139968872f) + ((1.6970666646957397f - _2080) * _2086)) * (Material_272[19].y)) + (_2094 * (Material_272[19].z))) + ((Material_272[19].w) * ((_2108 + 0.12239699810743332f) + ((0.598390519618988f - _2108) * _2086)));
  float _2118 = (_2094 * (Material_272[19].y)) + (((_2100 + 0.023176999762654305f) + ((0.22682300209999084f - _2100) * _2086)) * (Material_272[19].z));
  float _2119 = ((Material_272[19].w) * _2094) + ((((1.8000000068241206e-07f - _2082) * _2086) + _2082) * (Material_272[19].y));
  float _2122 = t4[0].x;
  float _2137 = (((Material_272[20].x) * ((_2117 / _2122) - _2117)) + _2117) * _2077;
  float _2138 = (((Material_272[20].x) * ((_2118 / _2122) - _2118)) + _2118) * _2077;
  float _2139 = (((Material_272[20].x) * ((_2119 / _2122) - _2119)) + _2119) * _2077;
  float _2152 = _754 * 5.0f;
  float _2153 = _755 * 5.0f;
  float _2155 = rsqrt(dot(float3(_2152, _2153, _756), float3(_2152, _2153, _756)));
  float _2156 = _2155 * _2152;
  float _2157 = _2155 * _2153;
  float _2158 = _2155 * _756;
  float _2172 = 1.0f - dot(float3(_192, _193, _194), float3((mad(_2158, TEXCOORD11_centroid.x, mad(_2157, _145, (_2156 * TEXCOORD10_centroid.x))) * _205), (mad(_2158, TEXCOORD11_centroid.y, mad(_2157, _146, (_2156 * TEXCOORD10_centroid.y))) * _205), (mad(_2158, TEXCOORD11_centroid.z, mad(_2157, _147, (_2156 * TEXCOORD10_centroid.z))) * _205)));
  float _2178 = 1.0f - _773;
  bool _2179 = (_2178 <= 2.980232949312267e-08f);
  float _2180 = log2(_2178);
  float _2187 = (select(_2179, 0.0f, exp2(_2180 * 0.30000001192092896f)) * select((_2172 <= 2.980232949312267e-08f), 0.0f, (pow(_2172, 3.0f)))) * (Material_272[21].x);
  float _2198 = saturate(_800 * 10.0f);
  float _2202 = (_2198 * _2198) * (3.0f - (_2198 * 2.0f));
  float _2209 = saturate(saturate(1.0f - (abs((-0.10000002384185791f - _778) + _803) * 19.999996185302734f)));
  float _2213 = (_2209 * _2209) * (3.0f - (_2209 * 2.0f));
  float _2218 = ((Material_272[21].y) * _2202) * _2213;
  float _2220 = ((Material_272[21].z) * _2202) * _2213;
  float _2222 = ((Material_272[21].w) * _2202) * _2213;
  float4 _2238 = t8.Sample(s0, float2((TEXCOORD.x * 3.0f), (TEXCOORD.y * 3.0f)));
  float _2242 = frac(View_2616);
  float _2244 = (_2242 * 0.30000001192092896f) * _2238.z;
  float _2246 = ceil(View_2616) * 0.30000001192092896f;
  float _2253 = View_2636 + -1.0f;
  float4 _2255 = t8.SampleLevel(s6, float2(((_2244 + (TEXCOORD.x * 2.5f)) + _2246), ((_2244 + (TEXCOORD.y * 2.5f)) + _2246)), _2253);
  float _2262 = View_2616 + 0.5f;
  float _2265 = (frac(_2262) * 0.30000001192092896f) * _2238.z;
  float _2267 = ceil(_2262) * 0.5f;
  float4 _2272 = t8.SampleLevel(s0, float2(((_2267 + _1999) + _2265), ((_2267 + _2000) + _2265)), -1.0f);
  float _2280 = max(select((_2255.y <= 2.980232949312267e-08f), 0.0f, (pow(_2255.y, 5.0f))), select((_2272.y <= 2.980232949312267e-08f), 0.0f, (pow(_2272.y, 5.0f)))) * 2.0f;
  float _2281 = saturate(_2280);
  float _2282 = _2281 * 15.0f;
  float _2283 = _2281 * 7.256545066833496f;
  float _2284 = _2281 * 1.5364551544189453f;
  float _2286 = saturate(_2280 + -1.0f);
  float4 _2303 = t8.Sample(s0, float2((View_2616 * 3.0f), 0.0f));
  float _2305 = _2303.x * saturate(min(_2242, (1.0f - _2242)) * 2.0f);
  float _2306 = _2305 * (lerp(_2282, 50.0f, _2286));
  float _2307 = _2305 * (lerp(_2283, 31.041759490966797f, _2286));
  float _2308 = _2305 * (lerp(_2284, 12.239583969116211f, _2286));
  float _2311 = t4[0].x;
  float _2334 = ((((_2187 * (((Material_272[20].y) - _2137) + ((((Material_272[20].y) / _2122) - (Material_272[20].y)) * (Material_272[20].x)))) + _2137) + _2218) + ((Material_272[20].x) * ((_2218 / _2122) - _2218))) + ((((Material_272[20].x) * ((_2306 / _2311) - _2306)) + _2306) * (Material_272[22].x));
  float _2338 = ((((_2187 * (((Material_272[20].z) - _2138) + ((((Material_272[20].z) / _2122) - (Material_272[20].z)) * (Material_272[20].x)))) + _2138) + _2220) + ((Material_272[20].x) * ((_2220 / _2122) - _2220))) + ((((Material_272[20].x) * ((_2307 / _2311) - _2307)) + _2307) * (Material_272[22].x));
  float _2342 = ((((_2187 * (((Material_272[20].w) - _2139) + ((((Material_272[20].w) / _2122) - (Material_272[20].w)) * (Material_272[20].x)))) + _2139) + _2222) + ((Material_272[20].x) * ((_2222 / _2122) - _2222))) + ((((Material_272[20].x) * ((_2308 / _2311) - _2308)) + _2308) * (Material_272[22].x));
  float _2343 = _955 * 2.0f;
  float _2344 = saturate(_2343);
  float _2345 = _2344 * 0.3339478373527527f;
  float _2346 = _2344 * 0.44186076521873474f;
  float _2347 = _2344 * 0.8020830154418945f;
  float _2352 = saturate(_2343 + -1.0f);
  float _2359 = (_2345 + 0.06424528360366821f) + ((0.7291573882102966f - _2345) * _2352);
  float _2360 = (_2346 + 0.10287705808877945f) + ((0.7258760929107666f - _2346) * _2352);
  float _2361 = (_2347 + 0.18229199945926666f) + ((0.8177080154418945f - _2347) * _2352);
  float _2362 = _2359 * 0.10000000149011612f;
  float _2363 = _2360 * 0.10000000149011612f;
  float _2364 = _2361 * 0.10000000149011612f;
  float _2383 = (((_2362 - _2334) + ((Material_272[20].x) * ((_2362 / _2311) - _2362))) * _975) + _2334;
  float _2384 = (((_2363 - _2338) + ((Material_272[20].x) * ((_2363 / _2311) - _2363))) * _975) + _2338;
  float _2385 = (((_2364 - _2342) + ((Material_272[20].x) * ((_2364 / _2311) - _2364))) * _975) + _2342;
  float _2391 = asfloat((Material_192[3].w));
  float _2392 = abs(_2391);
  float _2393 = asfloat((Material_192[3].y));
  float _2394 = asfloat((Material_192[3].z));
  bool _2395 = (_2391 > 0.0f);
  if ((uint)_392 > (uint)15) {
    float _2412 = float((uint)((int)((uint)(4096u) >> (_392 & 15)))) * 0.000244140625f;
    float4 _2437 = t24.SampleLevel(s1, float2((((float((uint)((int)(((uint)(_392) >> 4) & select(_2395, 255, 63)))) * _2392) + _2394) + (frac(_2412 * _393) * _2393)), (((float((uint)(int)(select(_2395, (((uint)(_392) >> 12) & 255), (((uint)(_392) >> 10) & 63)))) * _2392) + _2394) + (frac(_2412 * _394) * _2393))), 0.0f);
    _2442 = _2437.x;
    _2443 = _2437.y;
    _2444 = _2437.z;
  } else {
    _2442 = (float((uint)((int)(((uint)((int)(Material_192[3].x)) >> 16) & 255))) * 0.003921568859368563f);
    _2443 = (float((uint)((int)(((uint)((int)(Material_192[3].x)) >> 8) & 255))) * 0.003921568859368563f);
    _2444 = (float((uint)((int)((Material_192[3].x) & 255))) * 0.003921568859368563f);
  }
  float _2445 = dot(float3(_2442, _2443, _2444), float3(0.2126390039920807f, 0.7151686549186707f, 0.07219231873750687f));
  float _2457 = (((Material_272[22].y) * (_2445 - _2442)) + _2442) * (Material_272[22].z);
  float _2458 = (((Material_272[22].y) * (_2445 - _2443)) + _2443) * (Material_272[22].z);
  float _2459 = (((Material_272[22].y) * (_2445 - _2444)) + _2444) * (Material_272[22].z);
  float _2465 = select((_2457 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_2457) * (Material_272[22].w)));
  float _2470 = select((_2458 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_2458) * (Material_272[22].w)));
  float _2475 = select((_2459 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_2459) * (Material_272[22].w)));
  float _2503 = select((_2465 >= 0.5f), (1.0f - (((1.0f - _2465) * 2.0f) * (Material_272[23].x))), ((_2465 * 2.0f) * (Material_272[24].x)));
  float _2505 = select((_2470 >= 0.5f), (1.0f - (((1.0f - _2470) * 2.0f) * (Material_272[23].y))), ((_2470 * 2.0f) * (Material_272[24].y)));
  float _2507 = select((_2475 >= 0.5f), (1.0f - (((1.0f - _2475) * 2.0f) * (Material_272[23].z))), ((_2475 * 2.0f) * (Material_272[24].z)));
  float _2520 = (Material_272[25].z) + ((select((_674 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_674) * (Material_272[24].w))) - (Material_272[25].x)) * (Material_272[25].y));
  float _2549 = t0[_556].x;
  float _2556 = saturate(min(_2549, ((((Material_272[28].y) - (Material_272[28].z)) * _2520) + (Material_272[28].z))));
  float _2569 = ((Material_272[29].y) * (_2556 - saturate((((Material_272[28].w) - (Material_272[29].x)) * _2520) + (Material_272[29].x)))) + _2556;
  float _2580 = (min(max(select((_2569 <= 2.980232949312267e-08f), 0.0f, (_2569 * _2569)), min(max(_2556, 0.0f), 0.8999999761581421f)), 1.0f) * saturate(((Material_272[28].x) * (_686 + -1.0f)) + 1.0f)) * saturate((_572 + 0.8500000238418579f) + (Material_272[29].z));
  float _2581 = saturate(_2580);
  float _2588 = (_2581 * ((((((Material_272[26].x) - (Material_272[27].x)) * _2520) + (Material_272[27].x)) * _2503) - _2503)) + _2503;
  float _2589 = (_2581 * ((((((Material_272[26].y) - (Material_272[27].y)) * _2520) + (Material_272[27].y)) * _2505) - _2505)) + _2505;
  float _2590 = (_2581 * ((((((Material_272[26].z) - (Material_272[27].z)) * _2520) + (Material_272[27].z)) * _2507) - _2507)) + _2507;
  float _2601 = (((_2588 * (Material_272[29].w)) - _2588) * _746) + _2588;
  float _2602 = (((_2589 * (Material_272[29].w)) - _2589) * _746) + _2589;
  float _2603 = (((_2590 * (Material_272[29].w)) - _2590) * _746) + _2590;
  float _2604 = _737 * 0.800000011920929f;
  float _2611 = ((0.75f - _2601) * _2604) + _2601;
  float _2612 = ((0.75f - _2602) * _2604) + _2602;
  float _2613 = ((0.75f - _2603) * _2604) + _2603;
  float _2620 = ((0.800000011920929f - _2611) * _719) + _2611;
  float _2621 = ((0.800000011920929f - _2612) * _719) + _2612;
  float _2622 = ((0.800000011920929f - _2613) * _719) + _2613;
  float _2626 = _2620 - (_2620 * _2076);
  float _2627 = _2621 - (_2621 * _2076);
  float _2628 = _2622 - (_2622 * _2076);
  float _2629 = 1.0f - _686;
  float _2646 = max(select((_2629 <= 2.980232949312267e-08f), 0.0f, (pow(_2629, 2.5f))), saturate((((dot(float3(_2626, _2627, _2628), float3(0.29899999499320984f, 0.5870000123977661f, 0.11400000005960464f)) - (Material_272[30].x)) * (Material_272[30].y)) * (Material_272[30].z)) + (Material_272[30].w)));
  float _2659 = saturate((((Material_272[32].y) - (Material_272[32].z)) * select((_2646 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_2646) * (Material_272[32].x)))) + (Material_272[32].z));
  float _2683 = ((((Material_272[34].x) - _2626) + (((Material_272[33].x) - (Material_272[34].x)) * _2659)) * _818) + _2626;
  float _2684 = ((((Material_272[34].y) - _2627) + (((Material_272[33].y) - (Material_272[34].y)) * _2659)) * _818) + _2627;
  float _2685 = ((((Material_272[34].z) - _2628) + (((Material_272[33].z) - (Material_272[34].z)) * _2659)) * _818) + _2628;
  float _2692 = ((_2359 - _2683) * _975) + _2683;
  float _2693 = ((_2360 - _2684) * _975) + _2684;
  float _2694 = ((_2361 - _2685) * _975) + _2685;
  bool _2695 = (_2693 < _2694);
  float _2696 = select(_2695, _2694, _2693);
  float _2697 = select(_2695, _2693, _2694);
  bool _2700 = (_2692 < _2696);
  float _2701 = select(_2700, _2696, _2692);
  float _2703 = select(_2700, _2692, _2696);
  float _2705 = _2701 - min(_2703, _2697);
  float _2715 = ((_2705 / (_2701 + 1.000000013351432e-10f)) * 0.800000011920929f) + 0.20000000298023224f;
  float _2720 = select((_2715 <= 2.980232949312267e-08f), 0.0f, (pow(_2715, 0.5f)));
  float _2721 = abs(select(_2700, select(_2695, 0.6666666865348816f, -0.3333333432674408f), select(_2695, -1.0f, 0.0f)) + ((_2703 - _2697) / ((_2705 * 6.0f) + 1.000000013351432e-10f))) * 6.0f;
  float _2749 = ((((saturate(abs(_2721 + -3.0f) + -1.0f) + -1.0f) * _2720) + 1.0f) * 3.0f) * (Material_272[35].x);
  float _2750 = ((((saturate(2.0f - abs(_2721 + -2.0f)) + -1.0f) * _2720) + 1.0f) * 3.0f) * (Material_272[35].y);
  float _2752 = ((Material_272[35].z) * 3.0f) * (((saturate(2.0f - abs(_2721 + -4.0f)) + -1.0f) * _2720) + 1.0f);
  float _2760 = (((Material_272[35].x) - _2749) * (Material_272[35].w)) + _2749;
  float _2761 = (((Material_272[35].y) - _2750) * (Material_272[35].w)) + _2750;
  float _2762 = (((Material_272[35].z) - _2752) * (Material_272[35].w)) + _2752;
  float _2781 = (Material_272[36].y) * (1.0f - saturate((View_2616 - (Material_272[36].x)) * 3.3333332538604736f));
  float _2789 = _991 * 5.0f;
  float _2790 = _992 * 5.0f;
  float _2792 = rsqrt(dot(float3(_2789, _2790, _993), float3(_2789, _2790, _993)));
  float _2793 = _2792 * _2789;
  float _2794 = _2792 * _2790;
  float _2795 = _2792 * _993;
  float _2809 = 1.0f - dot(float3(_192, _193, _194), float3((mad(_2795, TEXCOORD11_centroid.x, mad(_2794, _145, (_2793 * TEXCOORD10_centroid.x))) * _205), (mad(_2795, TEXCOORD11_centroid.y, mad(_2794, _146, (_2793 * TEXCOORD10_centroid.y))) * _205), (mad(_2795, TEXCOORD11_centroid.z, mad(_2794, _147, (_2793 * TEXCOORD10_centroid.z))) * _205)));
  float _2819 = (select((_2809 <= 2.980232949312267e-08f), 0.0f, (pow(_2809, 5.0f))) * (select((_2781 <= 2.980232949312267e-08f), 0.0f, (pow(_2781, 5.0f))) + (Material_272[36].z))) * select(_2179, 0.0f, exp2(_2180 * 1.5f));
  float _2829 = (_2819 * ((_2760 - _2383) + ((Material_272[20].x) * ((_2760 / _2311) - _2760)))) + _2383;
  float _2830 = (_2819 * ((_2761 - _2384) + ((Material_272[20].x) * ((_2761 / _2311) - _2761)))) + _2384;
  float _2831 = (_2819 * ((_2762 - _2385) + ((Material_272[20].x) * ((_2762 / _2311) - _2762)))) + _2385;
  float _2834 = saturate((_1942 + -0.20000000298023224f) * 1.4285714626312256f);
  float _2842 = (Material_272[36].w) * View_2616;
  float _2843 = _2842 * 0.05000000074505806f;
  float _2855 = ((1.0f - (_1875 * _1480)) * 0.10000000149011612f) + -0.05000000074505806f;
  float _2864 = (mad(TEXCOORD10_centroid.z, _194, mad(TEXCOORD10_centroid.y, _193, (_192 * TEXCOORD10_centroid.x))) * _2855) + (((Material_272[16].w) * TEXCOORD.x) * (Material_272[37].x));
  float _2865 = (mad(_147, _194, mad(_146, _193, (_192 * _145))) * _2855) + (((Material_272[16].w) * TEXCOORD.y) * (Material_272[37].x));
  float4 _2868 = t8.SampleLevel(s0, float2((_2864 + _2843), (_2865 + _2843)), _1133);
  float4 _2875 = t8.SampleLevel(s0, float2((_2864 - _2843), (_2865 + (_2842 * 0.029999999329447746f))), _1133);
  float _2878 = saturate(_1875 * 2.5f);
  float _2883 = max(abs(1.0f - max(0.0f, dot(float3(_1994, _1996, _1998), float3(_192, _193, _194)))), 9.999999747378752e-05f);
  float _2902 = ((((_2878 * _2878) * ((((_1480 * _1057) * _2834) * (_2868.x + _2868.z)) * _2875.y)) * select((_2883 <= 2.980232949312267e-08f), 1.0f, (1.0f - (pow(_2883, 6.0f))))) * (Material_272[37].y)) * exp2(-0.0f - log2(_2311));
  float _2903 = _2902 + (_2829 - (_2829 * _2834));
  float _2904 = _2902 + (_2830 - (_2830 * _2834));
  float _2905 = _2902 + (_2831 - (_2831 * _2834));
  float _2908 = View_2616 * 0.10000000149011612f;
  float4 _2915 = t10.SampleBias(s8, float2((_2908 + TEXCOORD.x), (_2908 + TEXCOORD.y)), View_2636, int2(0, 0));
  float _2929 = saturate((View_2616 - (Material_272[37].z)) * (Material_272[37].w));
  float _2938 = ((Material_272[38].x) * (saturate((View_2620 - (Material_272[37].z)) * (Material_272[37].w)) - _2929)) + _2929;
  float _2943 = select((abs(Material_272[37].z) > 9.999999747378752e-06f), select(((Material_272[37].z) >= 0.0f), _2938, 0.0f), _2938);
  float _2951 = saturate(((Material_272[38].z) + _2943) + (((_2943 * -2.0f) + 1.0f) * (Material_272[38].y)));
  float _2952 = _2951 * _2951;
  float4 _2959 = t11.SampleLevel(s9, float2(((_2952 * ((_2915.x * 0.699999988079071f) + -0.3499999940395355f)) + (TEXCOORD.x * 0.5f)), ((_2952 * ((_2915.y * 0.699999988079071f) + -0.3499999940395355f)) + (TEXCOORD.y * 0.5f))), _2253);
  float _2969 = saturate(saturate(1.0f - (abs(((_2951 * 1.5f) + -0.5f) - _2959.x) * 5.000000476837158f)));
  float _2973 = (_2969 * _2969) * (3.0f - (_2969 * 2.0f));
  float _2977 = _2903 - (_2973 * _2903);
  float _2978 = _2904 - (_2973 * _2904);
  float _2979 = _2905 - (_2973 * _2905);
  float _2997 = _2692 - (_2834 * _2692);
  float _2998 = _2693 - (_2834 * _2693);
  float _2999 = _2694 - (_2834 * _2694);
  float _3002 = select((_2959.y <= 2.980232949312267e-08f), 0.0f, (_2959.y * _2959.y));
  float _3019 = saturate((((Material_272[39].w) - (Material_272[40].x)) * dot(float4(_647, _648, _649, _650), float4((Material_272[10].x), (Material_272[10].y), (Material_272[10].z), (Material_272[10].w)))) + (Material_272[40].x));
  float _3021 = _3019 - (_3019 * _737);
  float _3023 = _3021 - (_3021 * _2077);
  float _3031 = ((((Material_272[40].z) - _3023) + (((Material_272[40].y) - (Material_272[40].z)) * _2659)) * _818) + _3023;
  float _3036 = (((0.5f - (_955 * 0.5f)) - _3031) * _975) + _3031;
  float _3040 = _3036 - (_3036 * select((_2834 < 0.6000000238418579f), 0.0f, 1.0f));
  float4 _3066 = t12.Sample(s0, float2((frac(View_1936.x * 8192.0f) + (_168 * 0.00390625f)), (frac(View_1936.y * 8192.0f) + (_169 * 0.00390625f))));
  float _3070 = 1.0f - abs(_572);
  float _3089 = 1.0f / (MaterialCollection0_000.FMaterialCollection0Constants_000[19].w);
  float4 _3099 = t13.SampleLevel(s12, float2(((((_168 - (MaterialCollection0_000.FMaterialCollection0Constants_000[19].x)) + (View_1936.x * 2097152.0f)) + (((_3066.x + -0.5f) + (_3070 * (0.5f - _3066.x))) * 120.0f)) * _3089), ((((_169 - (MaterialCollection0_000.FMaterialCollection0Constants_000[19].y)) + (((_3066.y + -0.5f) + (_3070 * (0.5f - _3066.y))) * 120.0f)) + (View_1936.y * 2097152.0f)) * _3089)), 0.0f);
  float _3130 = (MaterialCollection0_000.FMaterialCollection0Constants_000[19].w) * 0.30000001192092896f;
  float _3137 = (1.0f - saturate((float((int)(((int)(uint)((bool)(_3099.w > 0.0f))) - ((int)(uint)((bool)(_3099.w < 0.0f))))) * saturate(((((_170 + (View_1936.z * 2097152.0f)) - (MaterialCollection0_000.FMaterialCollection0Constants_000[19].z)) - (_3099.w * (MaterialCollection0_000.FMaterialCollection0Constants_000[9].z))) - (Material_272[41].z)) * -0.019999999552965164f)) - saturate((select(_191, (((View_1248.x * _148) + View_1248.y) + (1.0f / ((View_1248.z * _148) - View_1248.w))), SV_Position.w) - _3130) / _3130))) * (((((Material_272[41].x) - (Material_272[41].y)) + (((Material_272[40].w) - (Material_272[41].x)) * (MaterialCollection0_000.FMaterialCollection0Constants_000[9].y))) * _2580) + (Material_272[41].y));
  float _3140 = ((0.10000000149011612f - _3137) * _746) + _3137;
  float _3143 = ((0.30000001192092896f - _3140) * _737) + _3140;
  float _3145 = _3143 - (_3143 * _2077);
  float _3161 = saturate(saturate((((Material_272[42].x) - (Material_272[42].y)) * select((_662 <= 2.980232949312267e-08f), 0.0f, exp2(log2(_662) * (Material_272[41].w)))) + (Material_272[42].y)));
  float _3165 = saturate((_572 + -0.5f) * 2.5f) * _2580;
  float _3178 = ((((Material_272[42].z) - _3161) + ((0.019999999552965164f - (Material_272[42].z)) * max(0.0f, select((_3165 <= 2.980232949312267e-08f), 0.0f, (pow(_3165, 15.0f)))))) * _2580) + _3161;
  float _3181 = ((0.15000000596046448f - _3178) * _746) + _3178;
  float _3184 = ((0.25f - _3181) * _737) + _3181;
  float _3187 = ((1.0f - _3184) * _2077) + _3184;
  float _3202 = ((saturate((((Material_272[42].w) - (Material_272[43].x)) * select((_2659 <= 2.980232949312267e-08f), 0.0f, (pow(_2659, 0.6499999761581421f)))) + (Material_272[43].x)) - _3187) * _818) + _3187;
  float _3207 = ((((_955 * 0.7999999523162842f) + 0.10000000149011612f) - _3202) * _975) + _3202;
  float _3210 = ((1.0f - _3207) * _2834) + _3207;
  float _3223 = ((Material_272[46].y) * _2503) * (Material_272[47].x);
  float _3224 = ((Material_272[46].z) * _2505) * (Material_272[47].x);
  float _3225 = ((Material_272[46].w) * _2507) * (Material_272[47].x);
  float _3236 = (((_3223 * (Material_272[47].y)) - _3223) * _746) + _3223;
  float _3237 = (((_3224 * (Material_272[47].y)) - _3224) * _746) + _3224;
  float _3238 = (((_3225 * (Material_272[47].y)) - _3225) * _746) + _3225;
  float _3248 = 1.0f - _2580;
  float _3265 = asfloat((Material_000[10].z));
  float _3266 = asfloat((Material_000[10].w));
  int _3267 = (Material_000[11].z) & 15;
  if (_3265 > 0.0f) {
    float _3282 = asfloat((Material_000[10].x)) * ((Material_272[47].w) * TEXCOORD.x);
    float _3283 = asfloat((Material_000[10].y)) * ((Material_272[47].w) * TEXCOORD.y);
    float _3288 = ddx_coarse(_3282) * _3265;
    float _3289 = ddx_coarse(_3283) * _3266;
    float _3290 = ddy_coarse(_3282) * _3265;
    float _3291 = ddy_coarse(_3283) * _3266;
    float _3292 = dot(float2(_3288, _3289), float2(_3288, _3289));
    float _3293 = dot(float2(_3290, _3291), float2(_3290, _3291));
    float _3297 = log2(max(_3292, _3293));
    _49[0] = View_4304.x;
    _49[1] = View_4304.y;
    _49[2] = View_4304.z;
    _49[3] = View_4304.w;
    float _3315 = float((uint)(int)(View_2664));
    int _3330 = int(floor((((View_2636 - min(((_3297 - log2(min(_3292, _3293))) * 0.5f), asfloat((Material_000[11].x)))) + (_3297 * 0.5f)) + (_49[(((uint)((int)(Material_000[11].y)) >> 28) & 3)])) + frac(frac(dot(float2(((_3315 * 32.665000915527344f) + SV_Position.x), ((_3315 * 11.8149995803833f) + SV_Position.y)), float2(0.0671105608344078f, 0.005837149918079376f))) * 52.98291778564453f))) + (((uint)((int)(Material_000[11].y)) >> 24) & 15);
    float _3333 = frac(_3282) * _3265;
    float _3334 = frac(_3283) * _3266;
    int _3336 = min(max(_3330, 0), _3267);
    int _3339 = _3336 & 31;
    int _3340 = (uint)(uint(_3333) + ((int)((Material_000[11].y) & 4095))) >> _3339;
    int _3343 = (uint)(uint(_3334) + ((int)(((uint)((int)(Material_000[11].y)) >> 12) & 4095))) >> _3339;
    uint4 _3345 = t20.Load(int3(_3340, _3343, _3336));
    _3359 = _3345.x;
    _3360 = _3333;
    _3361 = _3334;
    _3362 = select((_1808 == _208), (((_3340 | (Material_000[11].w)) | ((uint)(_3343 << 12))) | ((uint)(min(max((_3330 + 1), 0), (_3267 + 1)) << 24))), _1809);
  } else {
    _3359 = 0;
    _3360 = 0.0f;
    _3361 = 0.0f;
    _3362 = _1809;
  }
  float _3368 = asfloat((Material_192[4].w));
  float _3369 = abs(_3368);
  float _3370 = asfloat((Material_192[4].y));
  float _3371 = asfloat((Material_192[4].z));
  bool _3372 = (_3368 > 0.0f);
  if ((uint)_3359 > (uint)15) {
    float _3392 = float((uint)((int)((uint)(4096u) >> (_3359 & 15)))) * 0.000244140625f;
    float4 _3417 = t25.SampleLevel(s10, float2((((float((uint)((int)(((uint)(_3359) >> 4) & select(_3372, 255, 63)))) * _3369) + _3371) + (frac(_3392 * _3360) * _3370)), (((float((uint)(int)(select(_3372, (((uint)(_3359) >> 12) & 255), (((uint)(_3359) >> 10) & 63)))) * _3369) + _3371) + (frac(_3392 * _3361) * _3370))), 0.0f);
    _3423 = _3417.x;
    _3424 = _3417.y;
    _3425 = _3417.z;
    _3426 = _3417.w;
  } else {
    _3423 = (float((uint)((int)(((uint)((int)(Material_192[4].x)) >> 16) & 255))) * 0.003921568859368563f);
    _3424 = (float((uint)((int)(((uint)((int)(Material_192[4].x)) >> 8) & 255))) * 0.003921568859368563f);
    _3425 = (float((uint)((int)((Material_192[4].x) & 255))) * 0.003921568859368563f);
    _3426 = (float((uint)((int)((uint)((int)(Material_192[4].x)) >> 24))) * 0.003921568859368563f);
  }
  float _3439 = ((((1.0f - _3019) * select((_3248 <= 2.980232949312267e-08f), 0.0f, (_3248 * _3248))) * dot(float4(_3423, _3424, _3425, _3426), float4((Material_272[48].x), (Material_272[48].y), (Material_272[48].z), (Material_272[48].w)))) * (Material_272[49].x)) - _746;
  float _3444 = float((uint)(int)(View_2664));
  float _3453 = saturate((_2973 * ((_3002 * 0.5642363429069519f) - _2997)) + _2997);
  float _3454 = saturate(_2998 - (_2973 * _2998));
  float _3455 = saturate((_2973 * ((_3002 * 0.009403799660503864f) - _2999)) + _2999);
  float _3456 = saturate(_3040 - (_3040 * _2973));
  float _3457 = saturate(_3145 - (_3145 * _2834));
  float _3460 = (saturate(lerp(_3210, 1.0f, _2973)) * View_2560.y) + View_2560.x;
  float _3463 = saturate((_686 * View_2568.y) + View_2568.x);
  float _3464 = saturate(lerp(_3236, 0.6000000238418579f, _2604));
  float _3465 = saturate(lerp(_3237, 0.6000000238418579f, _2604));
  float _3466 = saturate(lerp(_3238, 0.6000000238418579f, _2604));
  float _3469 = t0[_195].x;
  int _3470 = asint(_3469);
  [branch]
  if ((bool)(View_3532 > 0.0f) && (bool)((_3470 & 8) != 0)) {
    float _3481 = View_2432.z * SV_Position.x;
    float _3482 = View_2432.w * SV_Position.y;
    float4 _3485 = t1.SampleLevel(s2, float2(_3481, _3482), 0.0f);
    float4 _3491 = t2.SampleLevel(s2, float2(_3481, _3482), 0.0f);
    float4 _3497 = t3.SampleLevel(s2, float2(_3481, _3482), 0.0f);
    float _3520 = ((_3491.x * 2.0f) + -1.003921627998352f) + (_3491.w * _1994);
    float _3521 = ((_3491.y * 2.0f) + -1.003921627998352f) + (_3491.w * _1996);
    float _3522 = ((_3491.z * 2.0f) + -1.003921627998352f) + (_3491.w * _1998);
    float _3524 = rsqrt(dot(float3(_3520, _3521, _3522), float3(_3520, _3521, _3522)));
    _3535 = (_3524 * _3520);
    _3536 = (_3524 * _3521);
    _3537 = (_3524 * _3522);
    _3538 = ((_3485.w * _3453) + _3485.x);
    _3539 = ((_3485.w * _3454) + _3485.y);
    _3540 = ((_3485.w * _3455) + _3485.z);
    _3541 = ((_3497.w * _3456) + _3497.x);
    _3542 = ((_3497.w * _3457) + _3497.y);
    _3543 = ((_3497.w * _3460) + _3497.z);
    _3544 = (_3485.w * _3464);
    _3545 = (_3485.w * _3465);
    _3546 = (_3485.w * _3466);
  } else {
    _3535 = _1994;
    _3536 = _1996;
    _3537 = _1998;
    _3538 = _3453;
    _3539 = _3454;
    _3540 = _3455;
    _3541 = _3456;
    _3542 = _3457;
    _3543 = _3460;
    _3544 = _3464;
    _3545 = _3465;
    _3546 = _3466;
  }
  float _3557 = saturate(_3542);
  float _3572 = _3542 * 0.07999999821186066f;
  float _3596 = (View_2512.w * (_3538 - (_3541 * _3538))) + View_2512.x;
  float _3597 = (View_2512.w * (_3539 - (_3541 * _3539))) + View_2512.y;
  float _3598 = (View_2512.w * (_3540 - (_3541 * _3540))) + View_2512.z;
  float _3607 = (View_2528.w * (lerp(_3572, _3538, _3541))) + View_2528.x;
  float _3608 = (View_2528.w * (lerp(_3572, _3539, _3541))) + View_2528.y;
  float _3609 = (View_2528.w * (lerp(_3572, _3540, _3541))) + View_2528.z;
  bool _3612 = !(View_3308 == 0.0f);
  float _3622 = select(_3612, 0.0f, _3607);
  float _3623 = select(_3612, 0.0f, _3608);
  float _3624 = select(_3612, 0.0f, _3609);
  float _3625 = dot(float3(_3622, _3623, _3624), float3(0.2126390039920807f, 0.7151686549186707f, 0.07219231873750687f));
  float _3649 = max(((((Material_272[39].x) - _2977) * (Material_272[38].w)) + _2977), 0.0f);
  float _3650 = max(((((Material_272[39].y) - _2978) * (Material_272[38].w)) + _2978), 0.0f);
  float _3651 = max(((((Material_272[39].z) - _2979) * (Material_272[38].w)) + _2979), 0.0f);
  [branch]
  if (View_2584 > 0.0f) {
    float _3658 = t0[((uint)(_195 + 18u))].x;
    float _3659 = t0[((uint)(_195 + 18u))].y;
    float _3660 = t0[((uint)(_195 + 18u))].z;
    float _3663 = t0[((uint)(_195 + 19u))].x;
    float _3664 = t0[((uint)(_195 + 19u))].y;
    float _3665 = t0[((uint)(_195 + 19u))].z;
    float _3668 = t0[((uint)(_195 + 17u))].w;
    float _3669 = _3658 * 2097152.0f;
    float _3670 = _3659 * 2097152.0f;
    float _3671 = _3660 * 2097152.0f;
    float _3672 = _3669 + _3663;
    float _3673 = _3670 + _3664;
    float _3674 = _3671 + _3665;
    float _3683 = t0[((uint)(_195 + 26u))].w;
    float _3686 = t0[((uint)(_195 + 27u))].w;
    float _3689 = t0[((uint)(_195 + 32u))].x;
    if (((bool)((bool)(abs((_171 - _3672) + (_177 - (_3663 - (_3672 - _3669)))) > (_3668 + 1.0f)) || (bool)(abs((_172 - _3673) + (_178 - (_3664 - (_3673 - _3670)))) > (_3683 + 1.0f)))) || (bool)(abs((_173 - _3674) + (_179 - (_3665 - (_3674 - _3671)))) > (_3686 + 1.0f))) {
      float _3735 = float((bool)(bool)(frac(dot(float3((frac(frac(_177 * 1.52587890625e-05f) + frac(_171 * 1.52587890625e-05f)) * 65536.0f), (frac(frac(_178 * 1.52587890625e-05f) + frac(_172 * 1.52587890625e-05f)) * 65536.0f), (frac(frac(_179 * 1.52587890625e-05f) + frac(_173 * 1.52587890625e-05f)) * 65536.0f)), float3(0.001154000055976212f, 0.001154000055976212f, 0.001154000055976212f))) > 0.5f));
      _3754 = (1.0f - _3735);
      _3755 = 1.0f;
      _3756 = _3735;
    } else {
      if (_3689 > 0.0f) {
        float _3752 = 1.0f - saturate(abs(max(abs(_165 - TEXCOORD_9.x), max(abs(_166 - TEXCOORD_9.y), abs(_167 - TEXCOORD_9.z))) - _3689) * 20.0f);
        _3754 = _3752;
        _3755 = 0.0f;
        _3756 = _3752;
      } else {
        _3754 = _3649;
        _3755 = _3650;
        _3756 = _3651;
      }
    }
  } else {
    _3754 = _3649;
    _3755 = _3650;
    _3756 = _3651;
  }
  [branch]
  if (((uint)(((View_4328 & (uint)(uint(SV_Position.y))) << (View_4324 & 31)) + ((int)(View_4328 & (uint)(uint(SV_Position.x)))))) == View_4332) {
    uint _3796; InterlockedAdd(u0[0], 1, _3796);
    if ((uint)((uint)(_3796 + 1u)) < (uint)View_4320) {
      u0[_3796 + 1u] = (uint)_3362;
    }
  }
  // ===== 复刻 Blender 参考工程的 NodeGroup.002 =====
  // 参数取自 鸣潮三渲二节点通用 的材质输入（先用 Up_ 这一槽验证链路）。
  float3 ynBase = float3(_3538, _3539, _3540);
  float3 ynN    = normalize(float3(_3535, _3536, _3537));
  // 视线向量：_165.._167 是原 shader 反推出来的像素世界坐标
  float3 ynToCam = normalize(float3(View_1824.x, View_1824.y, View_1824.z) - float3(_165, _166, _167));
  const float YN_OUTLINE_THRESHOLD = 0.72f;   // 旧 rim 项阈值（仅当 RIM_WEIGHT > 0 时生效）
  const float YN_OUTLINE_AA = 0.012f;         // 过渡宽度：越小线越硬
  const float YN_OUTLINE_STRENGTH = 1.0f;
  const float3 YN_OUTLINE_COLOR = float3(0.010f, 0.010f, 0.022f);
  const float YN_OUTLINE_PIXELS = 2.0f;       // 描边宽度（像素）。用 fwidth 归一化后，宽度与曲率/距离无关
  const float YN_OUTLINE_RIM_WEIGHT = 0.0f;
  const float YN_DEBUG_GRAD_SCALE = 1.0f;   // 旧 phi=1-dot(N,V) 内侧描边的权重，0 = 完全关闭

  const float3 YN_LIGHT_TINT = float3(1.000000f, 0.900629f, 0.581074f);  // 亮部色调
  const float3 YN_HIGHLIGHT  = float3(0.0f, 0.0f, 0.0f);                 // 高光贴图
  const float3 YN_LIGHT_GAIN  = float3(1.000f, 1.000f, 1.000f);  // 亮面对 Blender 参考图的比值
  const float3 YN_SHADOW_GAIN = float3(1.060f, 1.000f, 0.990f);  // 暗面：去掉叠加的额外红/黄（原来的 1.16/0.955/0.86 与 LIGHT_TINT 二次叠加后过红）
  const float  YN_METALLIC   = 1.0f;                                     // 金属度：Blender 材质默认 1.0（取"结果"支）
  const float  YN_ALPHA      = 1.0f;                                     // 透明度

  // ── 1. 主光：角色光（跟随镜头）＋ 世界补光 ──
  // 原实现照抄 Blender 场景里那盏太阳的方向，方向固定在世界空间。
  // 角色一旦转背，整片就掉进暗面 —— 卡通渲染不该跟场景光走，应该给角色专用打光。
  const float3 YN_SUN_DIR  = normalize(float3(-0.9105f, -0.3018f, 0.2826f));  // 场景太阳（只做补光）
  const float3 YN_WORLD_UP = float3(0.0f, 0.0f, 1.0f);   // UE 世界是 Z-up
  const float  YN_KEY_CAM_W = 0.70f;   // 角色光里"跟随镜头"的分量
  const float  YN_KEY_UP    = 1.00f;   // 相对视线上抬 → 顶部受光，保留立体感
  const float  YN_KEY_SIDE  = 0.28f;   // 略偏画面右侧，避免正中打光的平板感
  const float  YN_KEY_GAIN  = 0.85f;   // 角色光对色阶的贡献
  const float  YN_SUN_GAIN  = 0.35f;   // 场景太阳对色阶的贡献

  // 视线的水平分量 → 画面右向（= normalize(cross(世界up, 前向))）
  float2 ynCamH  = float2(ynToCam.x, ynToCam.y);
  float  ynCamHL = length(ynCamH);
  float2 ynCamFh = (ynCamHL > 1e-3f) ? (ynCamH / ynCamHL) : float2(0.0f, 1.0f);
  float  ynCamRx = -ynCamFh.y;
  float  ynCamRy = ynCamFh.x;

  float3 ynKeyDir = normalize(ynToCam * YN_KEY_CAM_W
                            + YN_WORLD_UP * YN_KEY_UP
                            + float3(ynCamRx, ynCamRy, 0.0f) * YN_KEY_SIDE);
  float  ynNdLKey = saturate(dot(ynN, ynKeyDir));
  float  ynNdLSun = saturate(dot(ynN, YN_SUN_DIR));
  float  ynNdL    = ynNdLKey;   // 保留旧名，描边与调试用
  float  ynLit    = saturate(ynNdLKey * YN_KEY_GAIN + ynNdLSun * YN_SUN_GAIN);

  // ── 2. 颜色渐变（EASE，四档）：0.1727/0.2864 → 0 ; 0.3636 → 0.1985 ; 0.4091 → 1 ──
  float ynToon = ynEaseRamp4(ynLit,
                             float4(0.1727f, 0.2864f, 0.3636f, 0.4091f),
                             float4(0.0f, 0.0f, 0.1985f, 1.0f));

  // ── 3. 暗部：颜色 HSV(value)，再与亮部色调做 OVERLAY(fac .5) ──
  const float YN_SHADOW_VALUE = 0.40f;   // 暗面明度：原 0.34 在暗面占比大时整片发闷
  float3 ynShadow = ynOverlay(ynHSV(ynBase, 1.0f, YN_SHADOW_VALUE), YN_LIGHT_TINT, 0.5f);
  ynShadow = saturate(ynShadow * YN_SHADOW_GAIN);
  // ── 4. 亮部：颜色与亮部色调 OVERLAY(fac .5)，再 HSV(sat 1.1, value 1.07) ──
  float3 ynLight = ynHSV(ynOverlay(ynBase, YN_LIGHT_TINT, 0.5f), 1.1f, 1.07f);
  ynLight = saturate(ynLight * YN_LIGHT_GAIN);

  // ── 5. 混合.001 = MIX(暗部, 亮部, 色阶) ──
  float3 ynC1 = lerp(ynShadow, ynLight, saturate(ynToon));

  // ── 6. 菲涅尔(IOR 1.45) → 颜色渐变.001 → 混合.002 ──
  float ynCos = saturate(dot(ynN, ynToCam));
  float ynF0 = 0.0337f;                                // ((1.45-1)/(1.45+1))^2
  float ynFres = ynF0 + (1.0f - ynF0) * pow(1.0f - ynCos, 5.0f);
  float ynRim = ynEaseRamp4(ynFres,
                            float4(0.0f, 0.6068f, 0.7182f, 1e9f),
                            float4(0.0f, 0.0f, 0.2173f, 0.2173f));
  float3 ynC2 = lerp(ynC1, ynBase, saturate(ynRim));

  // ── 7. 层权重(Blend 0.3) → 颜色渐变.002 → 混合.004(MULTIPLY, Factor=反色(颜色)) ──
  float ynLWBlend = 0.29999998f;
  float ynLW = pow(1.0f - ynCos, 1.0f + ynLWBlend * 4.0f);
  float ynG = ynEaseRamp4(ynLW,
                          float4(0.0f, 0.0591f, 0.4182f, 1e9f),
                          float4(1.0f, 0.1244f, 0.0067f, 0.0067f));
  float3 ynInv = 1.0f - ynBase;
  // 混合.004(MULTIPLY) -> 混合.003 这一支会把深色材质（头发）压到近黑。
  // 先按实测把它整体关掉，等标定出正确的 MULTIPLY 语义再开。
  const float YN_DARKEN = 0.0f;
  float3 ynC3 = lerp(ynC2, float3(0.0f, 0.0f, 0.0f),
                     saturate(dot(ynG.xxx, ynInv) * 0.33333334f) * YN_DARKEN);

  // 与游戏 tonemap 的总体亮度补偿（blender 是 AgX，游戏不是）
  const float YN_EXPOSURE = 1.0f;
  const float YN_WARM = 0.0f;   // 暖色偏移强度：0 = 严格按 Blender 原值
  ynC3 = saturate(ynC3 * YN_EXPOSURE);

  // ── 8. 金属：Metallic BSDF 以结果为基础色，经 CONSTANT 色阶后按金属度混合 ──
  float ynMetalLit = ynC3.r;                            // 单通道近似
  float ynMetalRamp = ynConstRamp(ynMetalLit, 0.2136f, 0.2342f, 0.5023f, 1.0f);
  float3 ynFinal = lerp(ynMetalRamp.xxx, ynC3, saturate(YN_METALLIC));

  // ── 9. 暖色校正：提红、轻提绿、压蓝 ──
  float3 ynWarmTint = float3(1.0f + YN_WARM, 1.0f + YN_WARM * 0.2f, 1.0f - YN_WARM * 1.2f);
  ynFinal = saturate(ynFinal * ynWarmTint);

  // ── 9a. 白平衡：抵消整体偏黄（游戏 LUT 与亮部色调都会往黄偏）──
  const float3 YN_WB = float3(1.000f, 0.780f, 1.314f);   // 蓝通道按实测补齐：游戏 B/G 0.871 vs Blender 1.113 → 1.030*1.276
  ynFinal = saturate(ynFinal * YN_WB);

  // ── 9b. 环境补光：游戏环境光偏暗，这里抬一个基础亮度（描边之前，避免把线洗掉）──
  const float3 YN_AMBIENT = float3(0.155f, 0.112f, 0.113f);   // 按 Blender 参考图暗部带实测色相标定：R/G 1.393、B/G 1.013（原值 R/G 2.44、B/G 0.78 偏红）
  // 只给皮肤补光：从 albedo 判断肤色（R>G>B 且红蓝差明显），头发偏蓝、白衣低饱和，都会被排除
  float ynSkinR = _3538, ynSkinG = _3539, ynSkinB = _3540;
  float ynSkinSat = max(max(ynSkinR, ynSkinG), ynSkinB) - min(min(ynSkinR, ynSkinG), ynSkinB);
  float ynIsSkin = (ynSkinR > ynSkinB + 0.08f) && (ynSkinR > ynSkinG) && (ynSkinG > ynSkinB) && (ynSkinSat > 0.10f) ? 1.0f : 0.0f;
  ynFinal = saturate(ynFinal + YN_AMBIENT * ynIsSkin * (1.0f - saturate(ynToon)));

  // ── 10. 描边：屏幕空间法线梯度 ──
  // ddx/ddy 是"相邻像素的法线差"，因此阈值筛出来的是固定宽度的像素带，
  // 不会像 1-dot(N,V) 那样在圆面上变粗、平面上变细，也不会把整个暗面压黑。
  // ndl 在轮廓处趋于 0，fwidth(ndl) 是它每像素的变化量，
  // 于是 ndl / fwidth(ndl) 就是"这个像素离轮廓线还有几个像素" —— 除以它之后宽度与曲率、距离全都无关。
  float ynNdl = saturate(dot(ynN, ynToCam));
  float ynNdlW = max(fwidth(ynNdl), 1e-5f);
  float ynPixelsToEdge = ynNdl / ynNdlW;
  float ynEdgeGrad = 1.0f - smoothstep(YN_OUTLINE_PIXELS - 0.75f, YN_OUTLINE_PIXELS + 0.75f, ynPixelsToEdge);
  // 法线本身有量化噪声，ndl 在内部也会抖出小值；用 ndl 门控只保留真正接近轮廓的区域
  ynEdgeGrad *= smoothstep(0.42f, 0.12f, ynNdl);
  float ynOutlineRim = 1.0f - ynNdl;
  float ynEdgeRim = smoothstep(YN_OUTLINE_THRESHOLD - YN_OUTLINE_AA, YN_OUTLINE_THRESHOLD + YN_OUTLINE_AA, ynOutlineRim);
  float ynEdge = saturate(max(ynEdgeGrad, ynEdgeRim * YN_OUTLINE_RIM_WEIGHT)) * YN_OUTLINE_STRENGTH;
  ynFinal = lerp(ynFinal, YN_OUTLINE_COLOR, saturate(ynEdge));


  // ── 输出 ──
  SV_Target.x = ynFinal.r;
  SV_Target.y = ynFinal.g;
  SV_Target.z = ynFinal.b;
  SV_Target.w = 0.0f;

  SV_Target_1.x = ((_3535 * 0.5f) + 0.5f);
  SV_Target_1.y = ((_3536 * 0.5f) + 0.5f);
  SV_Target_1.z = ((_3537 * 0.5f) + 0.5f);
  SV_Target_1.w = ((select(((_3470 & 256) != 0), 2.0f, 0.0f) + select(((_3470 & 512) != 0), 1.0f, 0.0f)) * 0.3333333432674408f);

  SV_Target_2.x = 0.0f;
  SV_Target_2.y = 0.0f;   // Specular=0：掐掉原生高光，暗面完全由自发光决定
  SV_Target_2.z = 1.0f;
  SV_Target_2.w = (float((uint)((int)((((uint)(_3470) >> 24) & 64) | 168))) * 0.003921568859368563f);

  SV_Target_3.x = 0.0f;
  SV_Target_3.y = 0.0f;
  SV_Target_3.z = 0.0f;
  SV_Target_3.w = 1.0f;

  SV_Target_4.x = 0.0f;   // 关掉 AO/自定义数据，避免原生光照再贡献
  SV_Target_4.y = 0.0f;
  SV_Target_4.z = 0.0f;
  SV_Target_4.w = saturate(_3439 - (_3439 * _818));
  float ynLum = dot(float3(_3538, _3539, _3540), float3(0.299f, 0.587f, 0.114f));
  float ynBias = (ynLum > 0.93f) ? 0.00004f : 0.0f;
  OutputSignature output_signature;
  output_signature.SV_Target = SV_Target;
  output_signature.SV_Target_1 = SV_Target_1;
  output_signature.SV_Target_2 = SV_Target_2;
  output_signature.SV_Target_3 = SV_Target_3;
  output_signature.SV_Target_4 = SV_Target_4;
  output_signature.Depth = saturate(SV_Position.z + ynBias);
  return output_signature;
}
