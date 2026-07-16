# Official_Implementation_of_Lagrangian_Limited-Area_Transformers_for_Typhoons (LLAT.ty)
**TC following forecasting model**

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
  - [Training the Model](#training-the-model)
  - [Inference](#inference)
- [Scripts](#scripts)
- [Contributing](#contributing)

## Overview
This repository is the official Implementation of Lagrangian Limited-Area Transformers for Typhoons (LLAT.ty). This repository is designed for training the LLAT.ty model. It leverages GPU resources to perform high-performance computations, includes tools for data conversion, model training, (inference and visualization). the inference and visualization is in FCNV2_couple_with_LLAT.sh and more detailed in https://github.com/yungyun0721/couple_FCNV2_LLAT.

## Installation

To set up the project environment:

1. **Clone the Repository**:
   ```bash
   git lfs install
   git clone Official_Implementation_of_Lagrangian_Limited-Area_Transformers_for_Typhoons
   mv Official_Implementation_of_Lagrangian_Limited-Area_Transformers_for_Typhoons LLAT.ty
   cd LLAT.ty
   ```

   *if no git lfs can install by conda*
   ```bash
   conda install -c conda-forge git-lfs
   ```

2. **Set Up the Environment**:
   Evironmental 1:
   - Ensure you have `micromamba` installed. If not, follow the installation instructions from [Micromamba's documentation](https://mamba.readthedocs.io/en/latest/installation.html).
   - Create and activate the `ty` environment:
     ```bash
     micromamba env create -f env_building/min-win_conda_env.yaml
     micromamba activate ty
     ```

   Evironmental 2:
   - Ensure you have `conda` installed.
   - Create and activate the `ty` environment:
     ```bash
     conda env create -f env_building/min-win_conda_env.yaml
     conda activate ty
     ```


## Usage
LLAT is a regional, TC-following model designed for tropical cyclone forecasting.  
Its architecture is conceptually similar to Pangu-Weather, but it operates on a moving regional domain centered on the tropical cyclone.

![LLAT model structure](demo_figures/figure1_model_structure.png)

The variables of LLAT model

![LLAT dataset](demo_figures/dataset.png)

- **Training the Model:**
  ```bash
  python train.py
  ```
  If using nano5 HPC:
  ```bash
  sbatch nano5_train_paral.sh
  ```
  This script is tailored for a specific computing cluster using the PJM job scheduler with the following parameters:
  - **partition**: `normal2` or `normal`
  - **Number of Nodes**: 1 GPU node
  - **GPU Cards**: 4
  - **Log Output**: Directed to `log/test.%j.out` and `log/test.%j.err`

- **Exporting to ONNX:**
  ```bash
  python export_onnx.py --ckpt_path path/to/checkpoint.ckpt --output_path path/to/output.onnx
  ```
- **Inference:**
  The LLAT.ty is a regional model. therefore, inferencing the model need global DWP model to provide the boundary condition. The example is 2-way interaction with FCNV2.
  the code is in *FCNV2_couple_with_LLAT.ipynb*. It can work in google colab. 
  - **Note:** The introduce of LLAT.ty inference can look at `https://github.com/yungyun0721/couple_FCNV2_LLAT`


## Scripts

Here are the scripts available in this project:

- **Training**: 
  - `train.py`
  - `nano5_train_paral.sh` (for nano5 HPC)

- **Inference and Result Plotting**: 
  - `FCNV2_couple_with_LLAT.ipynb` (detailed `https://github.com/yungyun0721/couple_FCNV2_LLAT`)

![LLAT result plotting](demo_figures/figure2_TC_plan_view.png)


- **Exporting to ONNX**: `export_onnx.py`


## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.