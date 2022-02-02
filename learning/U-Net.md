## Reference
1. [语义分割算法(UNet+Deeplab+HRNet+HarDNet)巡礼(知识详解+代码实现)](https://zhuanlan.zhihu.com/p/443580572?utm_source=pocket_mylist)
2. 
## Upsampling
1. 插植：双线性插植
2. FCN中的反卷积

## Loss Function

### CorssEntropy_Loss

### Focus_Loss

$-\frac{1}{N} \sum_{i=1}^{N}\left(a y_{i}\left(1-p_{i}\right)^{\gamma} \log p_{i}+(1-a)\left(1-y_{i}\right) p_{i}^{\gamma} \log \left(1-p_{i}\right)\right)$

> _引入(1-pi)r和pir使loss计算中对不均匀占多数的负样本关注度减小而正样本关注度增大，r为放大系数，a为权重_


### Dice Loss

$1-2 \frac{P \cap Y}{P+Y}$

>_不再以样本/像素的累积熵为指标而是以预测P和标签Y两个区域的相似程度为指标，相乘的交集除以相加的合集再乘2，【但其相乘的指数效应导致梯度变化剧烈，像素分类一旦错误造成的loss波动大，因此训练不稳定】_


### IoU_Loss

$1-\frac{P \cap Y}{P+Y-P \cap Y}$

> _类似于Dice_Loss的指标，只是将分母由合集换为了并集，注意各类别分类的平均交并比mIoU被用于检测和分割网络的评价指标_


### Tversky_Loss

$1-\frac{P \cap Y}{P \cap Y+a\left|P-Y\right|+b|Y- P|}$

>_|P-Y|代表假阳性，|Y-P|代表假阴性，a, b为权重。因此可以调节权重在假阳性和假阴性之间权衡(a=b=0.5时Tversky系数就是Dice系数)_


### Dice+Focus_Loss

$1-\left[2 \frac{P \cap Y}{P+Y}+\lambda \frac{1}{N} \sum_{i=1}^{N}\left(a Y_{i}\left(1-P_{i}^{\prime} \log P_{i}+(1-a)\left(1-Y_{i}\right) P_{i}^{\prime} \log \left(1-P_{i}\right)\right)\right]\right.$

>_λ为敏感系数，在Dice之后接上Focus提升小目标分割的稳定性_

