# Money Mentor

Welcome to our Application for the TIAA / ASU Hackathon, Money Mentor is an application that aims to address the problem of our generation (Gen-Z) currently being unable to plan and focus on retirement and savings.

This is a significant issue that needs to be addressed. Our solution is geared towards making the mundane task of savings fun by creating a game score app that assigns points based on spending habits.

This is a proof of concept, so much of the code has not been optimized or automated. Future improvements include better integration of the backend and frontend and making the application dynamic to accept user data.

The application is still in the prototyping stage and is mainly going to be presented as a pitch idea, so no real-world data has been used. In the backend, we have used the Plaid API to get dummy data for financial scoring and analysis.

Then we used GPT to summarize and create a scorecard of the data, which we later display in the frontend. The frontend is made using Flutter.

## Running the Front End

Download Flutter from flutter.dev

```sh
pip install jupyter
```

## Running the Backend Notebooks

To run the Jupyter Notebooks for the backend, you need to have a Python environment set up with Jupyter installed. Here are the steps to get the backend up and running:

1. **Install Dependencies**:
    Ensure that you have `jupyter` installed in your Python environment. You can install it using pip if you haven't already:

    ```sh
    pip install jupyter
    ```

2. **Start Jupyter Notebook**:
    Navigate to the directory where your notebooks are located and start Jupyter Notebook:

    ```sh
    jupyter notebook
    ```

3. **Open the desired notebook**:
    From the Jupyter dashboard that opens in your web browser, navigate to the notebook you wish to run and open it by clicking on it.

### Backend Directory Structure

The `Backend_Money_Mentor` directory contains 3 folders:

- `Plaid_Data_Sandbox`: Contains the API calls to Plaid. You don't need to run this code unless you want to fetch fresh dummy data.
- `Transaction_File_Creator`: Creates transaction summaries and classifies transactions into categories.
- `Summarizer_GPT_Calls`: Summarizes the transaction data and creates a scorecard.

### Using the `Plaid_Data_Sandbox`

If you need to run the `Plaid_API_Call.ipynb` notebook, you will need to replace the `sys.path.append()` line with the path to your own Plaid API keys. You dont need to run this notebook as the data has been appended to the CSV file, but in order to test it feel free!

```python
# Please insert your own plaid keys and remove this cell from the notebook

import sys
sys.path.append('../Gamefication-Retirement/KeysPlaid')

import Plaid_Keys

PLAID_CLIENT_ID = Plaid_Keys.PLAID_CLIENT_ID
PLAID_SECRET = Plaid_Keys.PLAID_SECRET
PLAID_ENV = Plaid_Keys.PLAID_ENV
```


### Using the `Transaction_Text_Creator.ipynb`

This notebook is responsible for processing transaction data and classifying it into essential and non-essential categories. It also generates a financial game score based on spending habits.

- Ensure that the transaction data CSV file from the Plaid API is located at `../Plaid_Data_Sandbox/transactions.csv`.

- Execute the cells in sequence. The notebook will classify each transaction and generate a summary along with financial game scores.

**Understanding the code:** This code categorized each transaction based on a hard coded essential and non-essential. The notebook assumes an 80% spending rate of the total income and allocates 50% of the assumed income to essential expenses and 30% to non-essentials. The scoring system is designed to encourage savings

### Using the `File_Reader_Scorecard_GPT.ipynb`

This Notebook is meant to read the transaction summary and pipe it into GPT to create a finance scorecard. It taked the transaction data makes users understand their data

In order to use it please install `opeanai` python library

```sh
pip install openai
```

And also install langchain

```sh
pip install langchain
```

Also replace this cell and inset the keys that was given for the hackathon

```python
# IF you are running this please just insert the os keys that was given

import sys
sys.path.append('../Gamefication-Retirement/KeysAI')

import OpenAIKeysTIAA
```

## Deployment and Presentation

As this project is a proof of concept for the TIAA / ASU Hackathon, the deployment is not required at this stage. The notebooks and front-end application can be run locally to demonstrate the functionality of Money Mentor.
