import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import joblib

# -------------------------------
# Page Configuration
# -------------------------------
st.set_page_config(page_title="AI Business Dashboard", layout="wide")

st.title("📊 AI Business Dashboard")
st.write("Superstore Sales Dashboard")

# -------------------------------
# Load Dataset
# -------------------------------
df = pd.read_csv("cleaned_superstore.csv")

# -------------------------------
# KPIs
# -------------------------------
total_sales = df["Sales"].sum()
total_profit = df["Profit"].sum()
total_orders = df["Order ID"].nunique()
total_customers = df["Customer ID"].nunique()
avg_delivery = df["Delivery Days"].mean()

col1, col2, col3, col4, col5 = st.columns(5)

col1.metric("Total Sales", f"₹{total_sales:,.0f}")
col2.metric("Total Profit", f"₹{total_profit:,.0f}")
col3.metric("Total Orders", f"{total_orders}")
col4.metric("Total Customers", f"{total_customers}")
col5.metric("Avg Delivery Days", f"{avg_delivery:.1f}")

st.divider()

# -------------------------------
# Sales by Category
# -------------------------------
st.subheader("Sales by Category")

sales_cat = df.groupby("Category")["Sales"].sum()

fig, ax = plt.subplots(figsize=(6,4))
sales_cat.plot(kind="bar", color="skyblue", ax=ax)
ax.set_ylabel("Sales")
st.pyplot(fig)

# -------------------------------
# Profit by Category
# -------------------------------
st.subheader("Profit by Category")

profit_cat = df.groupby("Category")["Profit"].sum()

fig, ax = plt.subplots(figsize=(6,4))
profit_cat.plot(kind="bar", color="green", ax=ax)
ax.set_ylabel("Profit")
st.pyplot(fig)

# -------------------------------
# Sales by Region
# -------------------------------
st.subheader("Sales by Region")

sales_region = (
    df.groupby("Region")["Sales"]
    .sum()
    .sort_values(ascending=False)
)

fig, ax = plt.subplots(figsize=(8,4))
sales_region.plot(kind="bar", color="orange", ax=ax)
ax.set_ylabel("Sales")
st.pyplot(fig)

# -------------------------------
# Monthly Sales Trend
# -------------------------------
st.subheader("Monthly Sales Trend")

month_order = [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
]

monthly_sales = (
    df.groupby("Order Month")["Sales"]
    .sum()
    .reindex(month_order)
)

fig, ax = plt.subplots(figsize=(8,4))
monthly_sales.plot(marker="o", ax=ax)
ax.set_ylabel("Sales")
st.pyplot(fig)

# -------------------------------
# Top 10 Products
# -------------------------------
st.subheader("Top 10 Products")

top_products = (
    df.groupby("Product Name")["Sales"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

fig, ax = plt.subplots(figsize=(8,5))
top_products.plot(kind="barh", color="royalblue", ax=ax)
ax.set_xlabel("Sales")
st.pyplot(fig)

st.success("Dashboard Loaded Successfully ✅")

# -------------------------------
# AI Sales Prediction
# -------------------------------

import joblib

# Load model and encoders
model = joblib.load("sales_prediction_model.pkl")
encoders = joblib.load("encoders.pkl")
st.write(encoders["Category"].classes_)
st.write(encoders["Region"].classes_)
st.write(encoders["Segment"].classes_)

st.header("🤖 AI Sales Prediction")

# Dropdowns
category = st.selectbox(
    "Category",
    sorted(df["Category"].unique())
)

region = st.selectbox(
    "Region",
    sorted(df["Region"].unique())
)

segment = st.selectbox(
    "Segment",
    sorted(df["Segment"].unique())
)

# Numeric inputs
quantity = st.number_input(
    "Quantity",
    min_value=1,
    value=2
)

discount = st.number_input(
    "Discount",
    min_value=0.0,
    max_value=1.0,
    value=0.10,
    step=0.01
)

shipping = st.number_input(
    "Shipping Cost",
    min_value=0.0,
    value=50.0
)

if st.button("Predict Sales"):

    category_enc = encoders["Category"].transform([str(category)])[0]
    region_enc = encoders["Region"].transform([str(region)])[0]
    segment_enc = encoders["Segment"].transform([str(segment)])[0]
    prediction = model.predict([[
        category_enc,
        region_enc,
        segment_enc,
        quantity,
        discount,
        shipping
    ]])

    st.success(f"Predicted Sales: ₹ {prediction[0]:,.2f}")