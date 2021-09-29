import flash
from flash.core.data.utils import download_data
from flash.image import ObjectDetectionData, ObjectDetector

# 1. Create the DataModule
# Dataset Credit: https://www.kaggle.com/ultralytics/coco128
download_data("https://github.com/zhiqwang/yolov5-rt-stack/releases/download/v0.3.0/coco128.zip", "data/")

datamodule = ObjectDetectionData.from_coco(
    train_folder="data/coco128/images/train2017/",
    train_ann_file="data/coco128/annotations/instances_train2017.json",
    val_split=0.1,
    image_size=128,
)

# 2. Build the task
model = ObjectDetector(head="efficientdet", backbone="d0", num_classes=datamodule.num_classes, image_size=128)

# 3. Create the trainer and finetune the model
trainer = flash.Trainer(max_epochs=1)
trainer.finetune(model, datamodule=datamodule, strategy="freeze")

# 4. Detect objects in a few images!
predictions = model.predict(
    [
        "data/coco128/images/train2017/000000000625.jpg",
        "data/coco128/images/train2017/000000000626.jpg",
        "data/coco128/images/train2017/000000000629.jpg",
    ]
)
print(predictions)

# 5. Save the model!
trainer.save_checkpoint("object_detection_model.pt")