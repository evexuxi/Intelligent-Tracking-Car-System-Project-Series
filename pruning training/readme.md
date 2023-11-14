This assignment required the completion of VGG11 model pruning experiments and training and testing on the publicly available dataset CIFAR10. We practiced this assignment to master how to lighten the network so that we can use pruning to improve model inference in the subsequent competition.

# Building a Convolutional Neural Network
Firstly, the construction of the VGG11 model is implemented in the vgg.py 

The structure of VGG is divided into four types according to the depth of its network layers, which are 11, 13, 16, and 19. The declarations of the configurations of these four corresponding network structures are given below.

```
1.	defaultcfg = {  
2.	    11 : [64, 'M', 128, 'M', 256, 256, 'M', 512, 512, 'M', 512, 512],  
3.	    13 : [64, 64, 'M', 128, 128, 'M', 256, 256, 'M', 512, 512, 'M', 512, 512],  
4.	    16 : [64, 64, 'M', 128, 128, 'M', 256, 256, 256, 'M', 512, 512, 512, 'M', 512, 512, 512],  
5.	    19 : [64, 64, 'M', 128, 128, 'M', 256, 256, 256, 256, 'M', 512, 512, 512, 512, 'M', 512, 512, 512, 512],  
6.	}  
```
# Setting hyperparameters to enable pre-training of the model before pruning
We need to complement the command line commands in the terminal to run the main.py file. Specifically, it is to set the dataset path in the command line (--dir_data), the save path for the pre-trained model weights (--save), and use the default values for the other parameters. As follows:
```
1.	python main.py --dir_data ./data --save './pretrained' --resume './pretrained/model_best.pth.tar'
```
Among other things, we also need to put the given pre-training weights file into the pretrained folder for pre-training first. And the specific parameter settings are shown in the main_finetune.py 
# Generate a channel mask based on the newly set cfg and the L1 norm of the convolution kernel
In the vggprune.py code, the model can be pruned according to the currently set cfg to modify the cfg of the original model until it meets the latest settings, and finally get the desired pruned model.
# Transplanting model weights based on channel masks
In vggprune.py, the weights to be retained from the original model are ported to the new model and saved.

Similarly, the vggprune,py file is run to implement model pruning by completing the commands on the command line. Set the path to the dataset (--dir_data), the pre-trained model weights file (--model), the path to save the model weights after pruning (--save), and use the defaults for the other parameters on the command line.
```
1.	python vggprune.py --dir_data ./data --model './pretrained/model_best.pth.tar' --save './prune'
```
# finetuning
After completing the command line in the terminal, run the main_finetune.py file. In this case, the main_finetune code file involves the following parameter settings:
|dataset |	cifar10 |
|---|---|
|batchsize	| 64 |
|test_batchsize	| 64 |
|epochs	| 50 |
|lr(learning rate)	| 0.1 |
|momentum	| 0.9 |

# test
In the test.py file, the baseline model before pruning and the model obtained after pruning are loaded and the model accuracy, number of parameters and computation are calculated for both of them, so that they can be used to compare the model performance and changes after pruning.

# result
After pruning, we record the model's loss and accuracy on the training and test sets, as shown in the table.
|**The best training model for VGG**	| |
|---|---|
|Accuracy	|91.92%|
|quantity of participants	|9228362.0|
|computational volume	|153375744.0|
|**Model after pruning**	| |
|Accuracy	|	68.42%|
quantity of participants	3325514.0|
|computational volume	|	101427712.0|
|**Model after pruning and finetuning** | |
|Accuracy	|		91.52%|
|computational volume	|	3325514.0|
|computational volume	|	101427712.0|

Through this experiment, I completed the pruning experiment of VGG11 model and trained and tested it on the public dataset CIFAR10. I used the school's HPC cluster platform to train the model, using a suitable virtual environment, running the relevant files through command line statements in the terminal and storing the model into a set folder. I achieved 50 epochs of training and testing, and completed model pruning and fine-tuning, as well as comparing the performance, number of parameters, and computation of the three types of models. After this experiment I have a more intuitive understanding of the principles and implementation steps of the filter pruning method, and a basic grasp of the possible effects of using it for pruning (and fine-tuning).

