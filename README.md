# My Portfolio

## Overview

Welcome to my Data Analyst Portfolio! This repository of projects of data analysis.

## Projects

### R

In this repository I put all data analysis project by R programming language. 

#### R / README
     In this repository I did Data analysis By R programming language. here I pick a data set Superstore_sales_data , which is available in Kaggle licences: public access. 

with that dataset I did Analysis by applying various methods.and i give them name as a different 
project. 

# project 1 : 
In this project I used the jupyter notebook, with R kernel and import the data set in the environment and did get started: 
in this project my primary focus to clean the data and make me to consistent . 

* but there is one problem I face when ever I start jupyter notebook and start the kernel, and needed to run all the previous code.  it face extremely lagging computing speed . because the file becomes heavy and it's take time and sometimes it crashed. 

* so I switched back to my lovely R studio and do all the project by R markdown YAML language. 


# Project 2 :
In this project I took the same dataset superstore sales data.and do the complete data analysis in the R studio. and in this repository i and in project 2 file i uploaded the raw file ( .Rmd ) .
because it is raw file it may difficult to understand. so I made a HTML file and deploy it by GitHub page.  here is the [link](https://ayandey1359.github.io/Project2/)  <- output page


# project 3 : 
Here i applied some my own concept and did it.in this project i took the same dataset ( superstore sales data, public access TRUE ). 

* Here i took that data and seperate it into four dataset according by its characteristics. then store all the dataset in the database ,(I primarily use the MySQL or MariaDB and as a host I used DBeaver).

* after completing all this steps.I install ODBC driver from MySQL community. and go to settings and granted permission of ODBC to ODBC driver. 

* then come back to R studio install some necessary packages
  1. ODBC package (connect database with R studio) 
  2. DBI package ( Sql environment, and run all command) 

after that . i made connection with database and R studio. and start the journey of data analysis .

###### Important link : 
in this repository one file name is Project3.Rmd : which is the main file ( raw ) , which is the 1st part of this project. 
though it is (.Rmd) file so it's may difficult to understand. so i deploy a GitHub page to understand all  the steps clearly. 
here is the [link](https://ayandey1359.github.io/Project3/)
and though this project 
 ###### MySQL Extension : 
though this project is not limited in just one single file, because this project have both R + SQL. 
in the sql part I used MySQL to understand, clean ,make it consistent . 
So the link of the sql script is here [link](https://github.com/ayandey1359/portfolio/blob/main/SQL/Project_3_SQL_R_ExtensionScript.sql)  <- MySQL_code


### SQL
In this repository I put all my data analysis project by MySQL .

## Skills

- Data Cleaning and Preprocessing
- Exploratory Data Analysis (EDA) / (project 3)
- Data Visualization by Tableau [link](project.in)

## Tools

- Programming R
- R Markdown 
- Jupyter Notebooks
- MySQL
- Tableau 
- LibreOffice Calc

## Education

- B.Tech  from Academy of Technology
- Diploma ( 3 years ) from Hooghly Institute of Technology
- Google Data Analytics Certified 


## How to Run the Projects
- R
Database and dataset i uploaded in a Data Source repository. To run R code just connect with GitHub.and set the working directory by setwd("")- and load the code file and run all chunk to get all out put . 
- and to get a markdown page. install R Markdown packages from CRAN. OR by console. and run the R Markdown page.  then knit with HTML with YAML header  to get a clear out put in a webpage.
- SQL
To run MySQL need to install MySQL server with ODBC  driver ( for project 3 ) becausex in project 3 SQL used in R Studio. so to run all SQL code in R need the opensource MySQL ODBC driver . 
can use any IED or MySQL terminal ( not recommended). 
IDE prefer- DBeaver or Workbench .
to run load the code and Run to get output.

## Contact Information

- Ayan Dey
- ayandey1359@gmail.com