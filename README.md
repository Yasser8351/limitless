# limitless

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

In this app i used
 php as backend.
 mysql database.
 MVVM Desing pattern.
 Provider State Management.
 Shared preferences to save information. 

 php file:
 create_cart.php :                                                                     
 login.php : User login to the application.                                                              
 my_orders.php : View user order.                                                               
 register.php :  Create a new user account.                                                           
 show_products.php : View products.
 
 I suggest creating another php file called Invoice.php
 
 Database Tables:
 I created three tables in the database :
 users: Contains user information such as phone number, password and registration date.
 products : Contains all the products that are displayed inside the application.
 orders: Contains order information such as order id,order Date,order status,product information such as (name,quantity, price).
 I suggest creating another table called Invoice.

 I used these packages:
 http.
 provider.
 fluttertoast.
 shared_preferences.


Suggestions for improving the app

 Adding and deleting quantity in cart Screen
 Combine orders into one invoice 
 This task is for the backend developer (Creates a table called Invoice)
 When the user sends an order, the data for the order is stored in the invoice table by the order_id
 and Send Api to receive invoice data in My Orders screen.
 Create these screens:
 Favert Screen.
 Track Orders Screen.
 Details screen.
 Categories Screen.
 Feedback Screen.
 Show Alert Dialoge after added orders.
 Add package connection_status_bar or any other similar package.
 Another app as a control panel.
 
