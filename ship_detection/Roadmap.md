# Roadmap

Check the [[To do list]].

## Object Detection Models
- [[Faster R-CNN]]
- [[FPN]]
- GCN
- Mask R-CNN
- Yolo v5
- GAN
- pix2pix


## Object Detection Datasets

### COCO dataset


## Object Detection Benchmark/Evaluation




## Results

### Trained and evaluated both on the cg pics
```
[03/10 11:17:35 d2.evaluation.fast_eval_api]: COCOeval_opt.accumulate() finished in 0.39 seconds.
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.864
 Average Precision  (AP) @[ IoU=0.50      | area=   all | maxDets=100 ] = 0.979
 Average Precision  (AP) @[ IoU=0.75      | area=   all | maxDets=100 ] = 0.978
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = 0.750
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.865
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=  1 ] = 0.900
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets= 10 ] = 0.900
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.900
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = 0.796
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.900
[03/10 11:17:35 d2.evaluation.coco_evaluation]: Evaluation results for bbox: 
|   AP   |  AP50  |  AP75  |  APs  |  APm   |  APl   |
|:------:|:------:|:------:|:-----:|:------:|:------:|
| 86.444 | 97.945 | 97.765 |  nan  | 74.995 | 86.497 |
[03/10 11:17:35 d2.evaluation.coco_evaluation]: Some metrics cannot be computed and is shown as NaN.
[03/10 11:17:35 d2.evaluation.coco_evaluation]: Per-category bbox AP: 
| category           | AP     | category           | AP     | category          | AP     |
|:-------------------|:-------|:-------------------|:-------|:------------------|:-------|
| Burke class        | 89.488 | Village Rain Level | 84.370 | Hainan Cargo Ship | 87.469 |
| Izumo level        | 91.811 | American Grade     | 76.199 | Ticonderoga       | 78.285 |
| Wasp class         | 80.714 | Brave Level        | 94.971 | Pohang Level      | 94.359 |
| Hainan Rescue Ship | 85.066 | Independence Level | 88.155 |                   |        |
OrderedDict([('bbox', {'AP': 86.44436148148843, 'AP50': 97.94543097154414, 'AP75': 97.76494320998246, 'APs': nan, 'APm': 74.99537700764333, 'APl': 86.49708388103564, 'AP-Burke class': 89.48796444421903, 'AP-Village Rain Level': 84.37036109802494, 'AP-Hainan Cargo Ship': 87.46937984435814, 'AP-Izumo level': 91.81086166365087, 'AP-American Grade': 76.19897237679042, 'AP-Ticonderoga': 78.28503016192937, 'AP-Wasp class': 80.71357393921379, 'AP-Brave Level': 94.9714645258837, 'AP-Pohang Level': 94.35919078361687, 'AP-Hainan Rescue Ship': 85.06571196196023, 'AP-Independence Level': 88.1554654967254})])
```
### Trained on cg pics and evaluated on real pics

```
Average Precision  (AP) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.035
 Average Precision  (AP) @[ IoU=0.50      | area=   all | maxDets=100 ] = 0.065
 Average Precision  (AP) @[ IoU=0.75      | area=   all | maxDets=100 ] = 0.033
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.041
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=  1 ] = 0.250
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets= 10 ] = 0.311
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.311
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.311
[04/07 10:10:31 d2.evaluation.coco_evaluation]: Evaluation results for bbox: 
|  AP   |  AP50  |  AP75  |  APs  |  APm  |  APl  |
|:-----:|:------:|:------:|:-----:|:-----:|:-----:|
| 3.508 | 6.506  | 3.304  |  nan  |  nan  | 4.100 |
[04/07 10:10:31 d2.evaluation.coco_evaluation]: Some metrics cannot be computed and is shown as NaN.
[04/07 10:10:31 d2.evaluation.coco_evaluation]: Per-category bbox AP: 
| category      | AP    | category     | AP     | category   | AP    |
|:--------------|:------|:-------------|:-------|:-----------|:------|
| America       | 1.720 | Burke        | 10.772 | Daring     | 0.000 |
| Independence  | 9.638 | Izumo        | 2.429  | Murasame   | 1.191 |
| Pohang        | 0.286 | Ticonderoga  | 5.538  | Wasp       | 0.000 |
| Hainan Rescue | nan   | Hainan Cargo | nan    |            |       |
OrderedDict([('bbox', {'AP': 3.5081729272994746, 'AP50': 6.506373755269533, 'AP75': 3.3042705721320678, 'APs': nan, 'APm': nan, 'APl': 4.100205452351203, 'AP-America': 1.7200023573785952, 'AP-Burke': 10.772416923728265, 'AP-Daring': 0.0, 'AP-Independence': 9.637863786378638, 'AP-Izumo': 2.4286546301688987, 'AP-Murasame': 1.1906901767623677, 'AP-Pohang': 0.28602860286028603, 'AP-Ticonderoga': 5.537899868418215, 'AP-Wasp': 0.0, 'AP-Hainan Rescue': nan, 'AP-Hainan Cargo': nan})])
```

### Trained and evaluated both on real pics
#### ResNet 50
``` 
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.651
 Average Precision  (AP) @[ IoU=0.50      | area=   all | maxDets=100 ] = 0.748
 Average Precision  (AP) @[ IoU=0.75      | area=   all | maxDets=100 ] = 0.735
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.651
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=  1 ] = 0.863
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets= 10 ] = 0.877
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.877
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.877
[04/07 10:36:28 d2.evaluation.coco_evaluation]: Evaluation results for bbox: 
|   AP   |  AP50  |  AP75  |  APs  |  APm  |  APl   |
|:------:|:------:|:------:|:-----:|:-----:|:------:|
| 65.051 | 74.823 | 73.521 |  nan  |  nan  | 65.051 |
[04/07 10:36:28 d2.evaluation.coco_evaluation]: Some metrics cannot be computed and is shown as NaN.
[04/07 10:36:28 d2.evaluation.coco_evaluation]: Per-category bbox AP: 
| category      | AP     | category     | AP     | category   | AP     |
|:--------------|:-------|:-------------|:-------|:-----------|:-------|
| America       | 40.060 | Burke        | 62.986 | Daring     | 79.038 |
| Independence  | 87.624 | Izumo        | 67.411 | Murasame   | 78.297 |
| Pohang        | 43.091 | Ticonderoga  | 82.715 | Wasp       | 44.240 |
| Hainan Rescue | nan    | Hainan Cargo | nan    |            |        |
OrderedDict([('bbox', {'AP': 65.0512104033142, 'AP50': 74.82302289801919, 'AP75': 73.520643982879, 'APs': nan, 'APm': nan, 'APl': 65.0512104033142, 'AP-America': 40.059720257740054, 'AP-Burke': 62.985619990570484, 'AP-Daring': 79.03818953323903, 'AP-Independence': 87.62376237623762, 'AP-Izumo': 67.41107444077741, 'AP-Murasame': 78.29677704612565, 'AP-Pohang': 43.091368919500646, 'AP-Ticonderoga': 82.7145214521452, 'AP-Wasp': 44.239859613491724, 'AP-Hainan Rescue': nan, 'AP-Hainan Cargo': nan})])
```
=======

#### ResNet 101
```
Average Precision  (AP) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.663
 Average Precision  (AP) @[ IoU=0.50      | area=   all | maxDets=100 ] = 0.748
 Average Precision  (AP) @[ IoU=0.75      | area=   all | maxDets=100 ] = 0.748
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.663
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=  1 ] = 0.800
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets= 10 ] = 0.800
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.800
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.800
[04/15 10:39:18 d2.evaluation.coco_evaluation]: Evaluation results for bbox: 
|   AP   |  AP50  |  AP75  |  APs  |  APm  |  APl   |
|:------:|:------:|:------:|:-----:|:-----:|:------:|
| 66.314 | 74.824 | 74.824 |  nan  |  nan  | 66.314 |
[04/15 10:39:18 d2.evaluation.coco_evaluation]: Some metrics cannot be computed and is shown as NaN.
[04/15 10:39:18 d2.evaluation.coco_evaluation]: Per-category bbox AP: 
| category      | AP     | category     | AP     | category   | AP     |
|:--------------|:-------|:-------------|:-------|:-----------|:-------|
| America       | 44.554 | Burke        | 60.317 | Daring     | 63.564 |
| Independence  | 85.495 | Izumo        | 67.921 | Murasame   | 77.898 |
| Pohang        | 55.361 | Ticonderoga  | 95.248 | Wasp       | 46.465 |
| Hainan Rescue | nan    | Hainan Cargo | nan    |            |        |
OrderedDict([('bbox', {'AP': 66.3136441849313, 'AP50': 74.82380106142482, 'AP75': 74.82380106142482, 'APs': nan, 'APm': nan, 'APl': 66.3136441849313, 'AP-America': 44.554455445544555, 'AP-Burke': 60.316831683168324, 'AP-Daring': 63.56435643564357, 'AP-Independence': 85.49504950495049, 'AP-Izumo': 67.92079207920793, 'AP-Murasame': 77.8977623037029, 'AP-Pohang': 55.36067892503536, 'AP-Ticonderoga': 95.24752475247524, 'AP-Wasp': 46.46534653465347, 'AP-Hainan Rescue': nan, 'AP-Hainan Cargo': nan})])
```

#### retinanet_R_101_FPN_3x.yaml

```
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.663
 Average Precision  (AP) @[ IoU=0.50      | area=   all | maxDets=100 ] = 0.748
 Average Precision  (AP) @[ IoU=0.75      | area=   all | maxDets=100 ] = 0.748
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Precision  (AP) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.663
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=  1 ] = 0.800
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets= 10 ] = 0.800
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=   all | maxDets=100 ] = 0.800
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= small | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area=medium | maxDets=100 ] = -1.000
 Average Recall     (AR) @[ IoU=0.50:0.95 | area= large | maxDets=100 ] = 0.800
[04/15 11:00:30 d2.evaluation.coco_evaluation]: Evaluation results for bbox: 
|   AP   |  AP50  |  AP75  |  APs  |  APm  |  APl   |
|:------:|:------:|:------:|:-----:|:-----:|:------:|
| 66.314 | 74.824 | 74.824 |  nan  |  nan  | 66.314 |
[04/15 11:00:30 d2.evaluation.coco_evaluation]: Some metrics cannot be computed and is shown as NaN.
[04/15 11:00:30 d2.evaluation.coco_evaluation]: Per-category bbox AP: 
| category      | AP     | category     | AP     | category   | AP     |
|:--------------|:-------|:-------------|:-------|:-----------|:-------|
| America       | 44.554 | Burke        | 60.317 | Daring     | 63.564 |
| Independence  | 85.495 | Izumo        | 67.921 | Murasame   | 77.898 |
| Pohang        | 55.361 | Ticonderoga  | 95.248 | Wasp       | 46.465 |
| Hainan Rescue | nan    | Hainan Cargo | nan    |            |        |
OrderedDict([('bbox', {'AP': 66.3136441849313, 'AP50': 74.82380106142482, 'AP75': 74.82380106142482, 'APs': nan, 'APm': nan, 'APl': 66.3136441849313, 'AP-America': 44.554455445544555, 'AP-Burke': 60.316831683168324, 'AP-Daring': 63.56435643564357, 'AP-Independence': 85.49504950495049, 'AP-Izumo': 67.92079207920793, 'AP-Murasame': 77.8977623037029, 'AP-Pohang': 55.36067892503536, 'AP-Ticonderoga': 95.24752475247524, 'AP-Wasp': 46.46534653465347, 'AP-Hainan Rescue': nan, 'AP-Hainan Cargo': nan})])
```