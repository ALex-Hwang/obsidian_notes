# Segmentaion

> We only focus on the medical segmentation models.

## Models

1. [[U-Net]]
	1. Nested U-Net
2. HarDNet-MSEG
3. Attention-based models


## Metrics
**Jaccard Index**
$$
\operatorname{IoU}=J(A, B)=\frac{|A \cap B|}{|A \cup B|}
$$
**Precision/Recall/F1-Score**

**Dice coefficient**
$$
\text { Dice }=\frac{2|A \cap B|}{|A|+|B|}
$$
When boolean data is applied:
$$
\text { Dice }=\frac{2 \mathrm{TP}}{2 \mathrm{TP}+\mathrm{FP}+\mathrm{FN}}=\mathrm{F} 1
$$
