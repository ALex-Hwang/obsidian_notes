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


