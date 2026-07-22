select * from pizza_sales

--Tổng doanh thu
SELECT 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales

-- Tính giá trị trung bình mỗi đơn hàng
SELECT 
	SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_id
FROM 
	pizza_sales

-- Tính tổng số lượng pizza đã bán
SELECT
	SUM(quantity) AS Total_Pizza_Sold
FROM 
	pizza_sales

-- Tính tổng số đơn hàng được đặt
SELECT
	COUNT( DISTINCT order_id) AS Total_orders
FROM 
	pizza_sales

-- Tính số lượng pizza trung bình trong mỗi đơn hàng
SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Avg_Pizzas_Per_order
FROM 
	pizza_sales

	-- Thống kê đơn hàng theo từng ngày trong tuần
SELECT 
	DATENAME(DW, order_date) AS order_day,
	COUNT(DISTINCT order_id) AS Total_orders
FROM
	pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Đếm tổng số đơn hàng được đặt theo từng tháng
SELECT 
	DATENAME(MONTH, order_date) AS Month_Name,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM
	pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

-- Tính tỉ lệ phần trăm doanh thu của từng nhóm pizza so với tổng doanh thu
SELECT
	pizza_category,
	SUM(total_price) AS Total_Sales,
	SUM(total_price) * 100 / 
	(SELECT SUM(total_price)
	 FROM pizza_sales) AS PCT
FROM
	pizza_sales
GROUP BY pizza_category

-- 
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
	CAST(SUM(total_price) * 100 / 
	(SELECT SUM(total_price)
	 FROM pizza_sales WHERE DATEPART(quarter, order_date) =1
) AS DECIMAL(10,2)) AS PCT
FROM
	pizza_sales
WHERE DATEPART(quarter, order_date) =1
GROUP BY pizza_size
ORDER BY PCT DESC

--Top 5 pizza có tổng doanh thu cao nhất
SELECT 
	TOP 5 pizza_name,
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--Top 5 pizza có tổng doanh thu thấp nhất
SELECT 
	TOP 5 pizza_name,
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 pizza được bán nhiều nhất theo số lượng
SELECT 
	TOP 5 pizza_name,
	SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--Top 5 pizza bán ít nhất theo số lượng
SELECT 
	TOP 5 pizza_name,
	SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- Top 5 loại pizza xuất hiện nhiều nhất trong đơn hàng
SELECT
	TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS Total_Oders
FROM
	pizza_sales
GROUP BY 
	pizza_name
ORDER BY
	Total_Oders ASC