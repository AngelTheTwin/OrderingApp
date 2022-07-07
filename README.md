# OrderingApp
Ordering app for iOS/iPadOS made in swift using SwiftUI.

## Screens
### Login

<img src="https://user-images.githubusercontent.com/62160767/177683422-f252fba4-1249-4477-b640-0d8f055db4ba.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177683458-9277e131-f2c3-4823-992d-e7e7caa64a4e.png" height="350" />

### Order
Screen where the meals are displayed in categories.

<img src="https://user-images.githubusercontent.com/62160767/177684584-3ac1f95d-1157-4965-b832-eaa331c0820d.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177684140-2f42edd1-0804-4c19-84dd-fa3b4bca0915.png" height="350" />

### Meal details
By tapping any meal, the user will open the Meal details screen, where the details of the meal are displayed and the user can add items to cart.

<img src="https://user-images.githubusercontent.com/62160767/177684879-a5749a56-b2cc-477c-bb6c-36cf6a2e9457.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177685064-be3e35da-d247-4854-98c1-6f158804f84a.png" height="350" />

## Addresses
The user's stored shipping addresses.  If there are no addresses registered, an animation will be shown instead.

<img src="https://user-images.githubusercontent.com/62160767/177686465-7ec0a37d-579e-433e-8ee1-502084f68a18.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177686503-fabcd342-20fd-423f-aab7-d49dc5543bcc.png" height="350" />

By tapping the top button the user will open the form sheet to add a new Address.

<img src="https://user-images.githubusercontent.com/62160767/177686755-094633eb-14d9-4a53-b333-5c5614bb0b8d.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177686665-36c7e98b-2834-42c0-90ae-276664486de7.png" height="350" />

Once saved, the new address will appear on the Addresses screen.

<img src="https://user-images.githubusercontent.com/62160767/177687149-6fd3936b-770c-4eb8-8eda-c16160d0364e.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177687196-1194ac70-9cb9-44a1-a3b3-327cfd6ee172.png" height="350" />

By tapping on any of the stored addresses, the sheet will be open with all the fields filled an now there will be an Update button followed by a Delete button

<img src="https://user-images.githubusercontent.com/62160767/177687428-d6705f92-f088-45cf-bc57-68442308fcd6.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177687373-dc62affb-82eb-44b8-9f85-777f5734b1ab.png" height="350" />

### Payment Methods
The Payment Methods screen has the same distribution as the Addresses one. as shown on the screenshots below, an animation will appear when there are no payment methods saved for the logged user.

<img src="https://user-images.githubusercontent.com/62160767/177687810-621bb1a5-8c86-4031-8e37-c68f9ef6866c.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177687868-9cf3b929-eae1-4b58-bc20-185c19d26535.png" height="350" />

And the Payment Method form looks like this...

<img src="https://user-images.githubusercontent.com/62160767/177688113-5b769094-e0ec-4bf1-8bb7-5c96169fe29a.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177688061-00c6edec-51e7-4c5b-a006-409fef987059.png" height="350" />

The card filps when the cvc gains and loses focus

<img src="https://user-images.githubusercontent.com/62160767/177690461-aec4ac8e-d2f6-452f-a9a3-64aaeaec617e.gif" height="350" width="162"/>

And can differenciate between several card providers.

<img src="https://user-images.githubusercontent.com/62160767/177690996-80c5486b-a4c8-482e-bb56-8dc8ddd9173e.gif" height="350" width="162"/>

Once saved, the new Payment Method will appear on the Payment Methods screen...

<img src="https://user-images.githubusercontent.com/62160767/177691382-bd62668b-a02a-4f6b-800c-2f162774dcff.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177691306-006c15f0-e215-4ba3-9a06-77d146259086.png" height="350" />

### Cart
The meals the user has added to their cart will appear here. If there’s no meals added, an animation will be shown instead.

<img src="https://user-images.githubusercontent.com/62160767/177685689-e2a2f4c6-00bb-4c87-be72-210f8af0b27d.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177685630-516cb36b-4e89-4132-8778-43ff32d279ba.png" height="350" />

Now with meals on cart!

<img src="https://user-images.githubusercontent.com/62160767/177685863-34b64c2f-6839-41fd-8efb-82753b56d07c.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177685902-044a0ba6-ca62-4a7c-82a0-7056e27b4e80.png" height="350" />

The user can tap and hold or use 3D touch on the cards to reveal options...

<img src="https://user-images.githubusercontent.com/62160767/177686164-5481c50a-efbb-4daa-882e-0029934a33b6.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177686096-83499c57-928e-4df8-ac57-f14e70f96166.png" height="350" />

By tapping the button at the bottom the user will open the Place your Order Form

<img src="https://user-images.githubusercontent.com/62160767/177691562-c1d7785f-cafc-46ae-92e9-d2565a89c7d9.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177691637-6f55d9cf-06cd-413f-9ca8-48d7f5292363.png" height="350" />

### Orders
Once the user has placed their order, it can be found in the Orders screen, each of one with a little badge showing the current state of the order, which variates between Placed, On the way, Delivered and Canceld, painted in blue, orange, green and red, respectively.

<img src="https://user-images.githubusercontent.com/62160767/177691917-9209ae27-1baa-41cd-82dc-34d09dff3bf8.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177691822-1f40710c-c067-46f6-9d69-9ebc0d6c2f83.png" height="350" />

By tapping on any order the user can see the details of the order...

<img src="https://user-images.githubusercontent.com/62160767/177692405-bcf947a5-e538-4eac-9e47-60276fa870b8.png" height="350" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/62160767/177692472-53f29412-afa3-4ca9-b584-eb5d33458017.png" height="350" />
