library(tidyverse)
attrition<-read.csv("D:/Downloads/archive/WA_Fn-UseC_-HR-Employee-Attrition.csv")
head(attrition)
dim(attrition)
str(attrition)
names(attrition)
unique(attrition$Attrition)
unique(attrition$Department)
table(attrition$Attrition)
prop.table(table(attrition$Attrition))*100
table(attrition$Department, attrition$Attrition)
#summary table department wise
dept_attrition<- attrition %>%
group_by(Department, Attrition)%>%
summarise(count=n())
#visualizing table
dept_attrition
#creating bar chart
ggplot(dept_attrition,aes( x = Department, y = count, fill = Attrition)) +
  geom_bar(stat = "identity") +
  labs(title = "Attrition by Department",
    x = "Department",
    y = "Number of Employees")
table(attrition$OverTime) #to count no. of employees who work overtime or not
table(attrition$OverTime, attrition$Attrition) #to know who left or not based on overtime
prop.table(table(attrition$OverTime, attrition$Attrition),1)*100 #for calculating percentage
#summary table based in overtime
over_time<- attrition%>% group_by(OverTime,Attrition)%>%summarise(Count=n())
over_time
over_time%>% ggplot(aes(OverTime,Count,fill=Attrition))+
  geom_bar(stat="identity")+
  labs(title = "Attrition by Overtime Status",
    x = "OverTime",
    y = "Employee Count")
#to compare the average salary of employees based on attrition
attrition%>% group_by(Attrition)%>% summarise(AverageIncome= mean(MonthlyIncome))
attrition%>%ggplot(aes(Attrition, MonthlyIncome))+
  geom_boxplot()+
  labs(
    title = "Monthly Income by Attrition Status",
    x = "Attrition",
    y = "Monthly Income"
  )
#creating income group
attrition$IncomeGroup<- cut(attrition$MonthlyIncome, breaks<-c(0,5000,10000,15000,20000),
                            labels<-c("Low","Medium","High","Very High"))
table(attrition$IncomeGroup, attrition$Attrition)
#Age Analysis
attrition%>% group_by(Attrition)%>%summarise(AverageAge=mean(Age))
ggplot(attrition, aes(x = Attrition,y = Age))+
  geom_boxplot() +
  labs(
    title = "Age Distribution by Attrition",
    x = "Attrition",
    y = "Age")
attrition$AgeGroup<-cut(attrition$Age, breaks=c(18,30,40,50,60),
                        labels = c(
                          "18-30","31-40","41-50","51-60"))
table(attrition$AgeGroup, attrition$Attrition)
#Job role vs Attrition
unique(attrition$JobRole)
table(attrition$JobRole,attrition$Attrition)
job_attrition<-attrition%>% group_by(JobRole, Attrition)%>% summarise(Count=n())
job_attrition
job_attrition%>%ggplot(aes(JobRole,Count,fill=Attrition))+
  geom_bar(stat="identity")+
  labs(title="Attrition by Job Role",
       x="Job Role",
       y="Employee Count")
job_attrition %>%
    filter(Attrition == "Yes") %>%
    arrange(desc(Count))
#selecting all the numeric columns
numeric_data<-attrition%>% select(where(is.numeric))
numeric_data<-numeric_data%>%select(-EmployeeCount, -StandardHours)#because they are constant for all observations
numeric_data
library(corrplot)
corrplot(correlation_matrix, method="color",type="upper",t1.cex=0.5, tl.srt = 45)
#data preparation for machine learning
str(attrition)
attrition<-attrition%>%mutate_if(is.character, as.factor)
str(attrition)
attrition<-attrition%>%select(-EmployeeCount,-StandardHours)
colSums(is.na(attrition))
levels(attrition$Attrition)
attrition_clean<-attrition
#splitting into train and test data
library(caret)
set.seed(123)#for the model to choose same training values every time
train_index <- createDataPartition(attrition_clean$Attrition,p = 0.8,list = FALSE)
train_data<-attrition_clean[train_index,]
test_data<-attrition_clean[-train_index,]
dim(train_data)#checking the dimension of training data set
dim(test_data)
#building the model
model<-glm(Attrition~Age+ MonthlyIncome+ OverTime+ JobLevel+ YearsAtCompany+ TotalWorkingYears,
           data=train_data,
           family="binomial")
summary(model)
#predicting probabilities on test data
prediction_probab<- predict(model, newdata=test_data, type="response")
prediction_probab
pred_class<-ifelse(prediction_probab>0.5,"Yes","No")#converting into attrition categories based on probability
pred_class
confusionMatrix(as.factor(pred_class),test_data$Attrition)
#calculating which variables are important
importance<-varImp(model) #using caret library
importance
plot(importance)