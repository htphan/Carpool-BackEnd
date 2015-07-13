# API Documentation for Carpool-App

## Table of Contents
1. [Pagination](#pagination)
2. [User Model](#user-model)
  * [Index](#users-index)
  * [Register](#register-user)
  * [Show User](#show-a-user)
  * [Update](#update-a-user)
  * [Login](#user-login)
  * [Delete](#delete-a-user)
3. [Child Model](#child-model)
  * [Index](#children-index)
  * [Create Child](#create-child)
  * [Show Child](#show-a-child)
  * [Update Child](#update-a-child)
  * [Delete Child](#delete-a-child)
4. [Medical Information Model](#medical-information-model)
  * [Show Medical Information](#show-medical-information)
  * [Create Medical Information](#create-medical-information)
  * [Update Medical Information](#update-medical-information)
  * [Delete Medical Information](#delete-medical-information)
5. [Contact Model](#contact-model)
  * [Contact Index for a Child](#contact-index-for-a-child)
  * [Contact Index for a User](#contact-index-for-a-user)
  * [Create Contact for Child](#create-contact-for-child)
  * [Create Contact for User](#create-contact-for-user)
  * [Update Contact](#update-contact)
  * [Delete Contact](#delete-contact)

## **Pagination**
All request methods that have pagination implemented in its use will will state "***Pagination Enabled***" in its description. If no 'page' or 'per' parameter is specified, the API will automatically apply its default. These parameters are passed in the path as a query or in the JSON request.

**Parameters**

Name | Default | Description
--- | --- | ---
page | 1 | **Optional.** Set the page of data to access.
per | 25 | **Optional.** Set how many items will be retrieved per page.

**Example Path**

`GET '/users?page=4&per=50'`

OR

`GET '/users?page=4'`

## **User Model**

#### Users Index

***Pagination Enabled:***
List of all users in the database.

Path:
`GET '/users'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All users were successfully returned.
204 | Success | The server successfully processed the request, but not content was returned due to an empty database.

**Example Response**

```
[
  {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Debbie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  },
  {
    "id": 2,
    "username": "HostTwinkies",
    "first_name": "Hostess",
    "last_name": "Twinkies",
    "address": "1010 Cake Road, Kansas City, MO",
    "phone_number": "800-876-3942",
    "email": "twinkie@hostess.com"
    "avatar": ""
  }
]

```

#### Register User

Allows the registration of a new user.

Path:
`POST '/users'`

**Parameters**

Name | Type | Description
--- | --- | ---
username | string | **Required.** Unique username for a new user.
password | string | **Required.** Password provided must be at least 6 characters long.
first_name | string | **Required.** First name of the user.
last_name | string | **Required.** Last name of the user.
email | string | **Required.** User's contact email.
address | string | **Optional.** Address of the user's desired location.
phone_number | string | **Optional.** User's contact number.
avatar | string | **Optional.** User's profile picture image link.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "password": "secretpassword",
  "first_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
}
```

**Example Response**

```
{
  "id": 1,
  "username": "LilDebbie",
  "first_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg",
  "access_token": "1af17e73721dbe0c40011b82ed4bb1a7dbe3ce29"
}
```

#### Show a User

Shows the attributes of a specified user.

Path:
`GET '/user/:username'`

**Parameters**
*None*

Code | Type | Description
---|---|---
200 | Success | Server successfully requested returned user data.
400 | Error | Bad Request. Specified parameters do not match.

**Example Response**

```
{
  "id": 1,
  "username": "LilDebbie",
  "first_name": "Lil",
  "last_name": "Debbie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
}
```

#### Update a User

Updates the specified attributes of a user. Forms should include all required fields to be passed with the request.

Path:
`PUT '/user/:username'`

**Parameters**

Name | Type | Description
--- | --- | ---
username | string | **Required.** Unique username for a new user.
password | string | **Required.** Password provided must be at least 6 characters long.
first_name | string | **Required.** First name of the user.
last_name | string | **Required.** Last name of the user.
email | string | **Required.** User's contact email.
address | string | **Optional.** Address of the user's desired location.
phone_number | string | **Optional.** User's contact number.
avatar | string | **Optional.** User's profile picture image link.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "password": "newsecretpassword",
  "first_name": "Lil",
  "last_name": "Teddie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
}
```

**Example Response**

```
{
  "id": 1,
  "username": "LilDebbie",
  "first_name": "Lil",
  "last_name": "Teddie",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "email": "lil@debbie.com"
  "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
}
```

#### User Login

Allows the login of a user to supply an access token.

Path: 
`POST '/users/login'`

**Parameters**

Name | Type | Description
--- | --- | ---
username | string | User's username as specified in the database.
password | string | User's password as specified in the database.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully supplied the user with an access token.
401 | Error | Unauthorized. Incorrect username and/or password combination.

**Example Input**

```
{
  "username": "LilDebbie",
  "password": "secretpassword"
}
```

**Example Response**

```
{
  "id": 1
  "username": "LilDebbie",
  "email": "lil@debbie.com",
  "access_token": "1af17e73721dbe0c40011b82ed4bb1a7dbe3ce29"
}
```

#### Delete a User

Deletes a specified user's account.

Path: 
`DELETE '/user/:username'`

**Parameters**
*None*

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's account.

**Example Response**

```
No message is returned. 
```

## **Child Model**

#### Children Index

List of all children that are associated with a specific user.

Path:
`GET '/user/:username/children'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All children were successfully returned.
400 | Error | Bad Request. Invalid parameters.

**Example Response**

```
[
  {
    "id": 1,
    "first_name": "Casa",
    "last_name": "Sanchez",
    "age": 7,
    "dob": "2007-12-01",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": 134,
    "weight": 100,
    "blood_type": "O",
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com"
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  {
    "id": 2,
    "first_name": "Lobos",
    "last_name": "Sanchez",
    "age": 8,
    "dob": "2006-11-01",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": 124,
    "weight": 95,
    "blood_type": "A",
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com"
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  }
]
```

#### Create Child

Creates a child associated to a specifed user.

Path:
`POST '/children'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Child's first name.
last_name | string | **Required.** Child's last name.
age | integer | Child's current age.
dob | string | Child's date of birth. If this parameter is used, the DD/MM/YYYY format **must** be used. The response for this parameter will be returned in the YYYY-MM-DD format.
address | string | Child's location to be picked up and dropped off.
phone_number | string | Child's phone number if applicable.
height | integer | Child's height in inches (in).
weight | integer | Child's weight in pounds (lb).
blood_type | string | Child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "30/5/2005",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499"
}
```

**Example Response**

```
{
  "id": 1,
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "2005-5-30",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "height": null,
  "weight": null,
  "parent": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
}
```

#### Show a Child

Shows the attributes of a specified child.

Path:
`GET '/child/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server successfully requested returned child data.
400 | Error | Bad Request. Specified parameters do not match.

**Example Response**

```
{
  "id": 1,
  "first_name": "Casa",
  "last_name": "Sanchez",
  "age": 7,
  "dob": "2007-12-01",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "height": 134,
  "weight": 100,
  "blood_type": "O",
  "parent": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
}
```

#### Update a Child

Updates the specified attributes of a child. Forms should include all required fields to be passed with the request.

Path:
`PUT '/child/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Child's first name.
last_name | string | **Required.** Child's last name.
age | integer | Child's current age.
dob | string | Child's date of birth. If this parameter is used, the DD/MM/YYYY format **must** be used. The response for this parameter will be returned in the YYYY-MM-DD format.
address | string | Child's location to be picked up and dropped off.
phone_number | string | Child's phone number if applicable.
height | integer | Child's height in inches (in).
weight | integer | Child's weight in pounds (lb).
blood_type | string | Child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "username": "LilDebbie",
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "30/5/2005",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499"
}
```

**Example Response**

```
{
  "id": 1,
  "first_name": "Jac",
  "last_name": "Nickelsen",
  "age": 10,
  "dob": "2005-5-30",
  "address": "10260 McKee Road, Collegedale, TN 37315",
  "phone_number": "800-522-4499",
  "height": null,
  "weight": null,
  "parent": {
    "id": 1,
    "username": "LilDebbie",
    "first_name": "Lil",
    "last_name": "Teddie",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "email": "lil@debbie.com"
    "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
  }
}
```

#### Delete a Child

Deletes a specified child.

Path: 
`DELETE '/child/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's child.

**Example Response**

```
No message is returned.
```

## **Medical Information Model**

#### Show Medical Information

Shows the medical information for a specified child

Path: 
`GET '/child/:id/medical'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Medical information was successfully returned.
204 | Success | No medical information associated with specified child.

**Example Response**

```
{
  "id": 1,
  "child": {
    "id": 1,
    "first_name": "Jac",
    "last_name": "Nickelsen",
    "age": 10,
    "dob": "2005-5-30",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": null,
    "weight": null,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com"
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  "conditions": "Diabetes, Eczema",
  "medications": "Lantus",
  "notes": "Use dosage and sliding scale directions provided in his backpack for if insulin administration is needed.",
  "allergies": "None",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": "O+"
}
```

#### Create Medical Information

Creates medical information for a specified child.

Path:
`POST '/child/:id/medical'`

**Parameters**

Name | Type | Description
--- | --- | ---
conditions | string | A child's medical conditions.
medications | string | Prescribed medications for the specified child.
notes | string | Any relevant medical information such as medication directions or special needs.
allergies | string | A child's allergies.
insurance | string | A child's medical insurance information.
religious_preference | string | A child's religious affiliation if medically relevant.
blood_type | string | A child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Server has processed the request and has successfully created the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "conditions": "Diabetes, Eczema",
  "medications": "Lantus",
  "notes": "Use dosage and sliding scale directions provided in his backpack for if insulin administration is needed.",
  "allergies": "None",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": "O+"
}
```

**Example Response**

```
  "id": 1,
  "child": {
    "id": 1,
    "first_name": "Jac",
    "last_name": "Nickelsen",
    "age": 10,
    "dob": "2005-5-30",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": null,
    "weight": null,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com"
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  "conditions": "Diabetes, Eczema",
  "medications": "Lantus",
  "notes": "Use dosage and sliding scale directions provided in his backpack for if insulin administration is needed.",
  "allergies": "None",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": "O+"
}
```

#### Update Medical Information

Updates the medical information of a child. Forms should still include all previous information even if they are not updated with the new parameters.

Path:
`PUT '/child/:id/medical'`

**Parmeters**

Name | Type | Description
--- | --- | ---
conditions | string | A child's medical conditions.
medications | string | Prescribed medications for the specified child.
notes | string | Any relevant medical information such as medication directions or special needs.
allergies | string | A child's allergies.
insurance | string | A child's medical insurance information.
religious_preference | string | A child's religious affiliation if medically relevant.
blood_type | string | A child's blood type.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Server has processed the request and has successfully updated the user.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "conditions": "Eczema",
  "allergies": "Peanuts",
  "insurance": "N/A",
  "religious_preference": "N/A",
}
```

**Example Response**

```
{
  "id": 1,
  "child": {
    "id": 1,
    "first_name": "Jac",
    "last_name": "Nickelsen",
    "age": 10,
    "dob": "2005-5-30",
    "address": "10260 McKee Road, Collegedale, TN 37315",
    "phone_number": "800-522-4499",
    "height": null,
    "weight": null,
    "parent": {
      "id": 1,
      "username": "LilDebbie",
      "first_name": "Lil",
      "last_name": "Teddie",
      "address": "10260 McKee Road, Collegedale, TN 37315",
      "phone_number": "800-522-4499",
      "email": "lil@debbie.com"
      "avatar": "https://i.imgur.com/KOoBDaKb.jpg"
    }
  },
  "conditions": "Eczema",
  "medications": null,
  "notes": null,
  "allergies": "Peanuts",
  "insurance": "N/A",
  "religious_preference": "N/A",
  "blood_type": null
}
```

#### Delete Medical Information

Deletes the medical information for a specified child.

Path:
`DELETE '/child/:id/medical'`

**Parameters*
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's child.

**Example Response**

```
No message is returned.
```

## **Contact Model**

#### Contact Index for a Child

List of all contacts that are associated with a specific child. *Note:* The contactable_type is the type of model that the contact belongs to. The contactable_id is the ID number of the Child/User in which the contact belongs to.

Path:
`GET '/child/:id/contacts'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All contacts were successfully returned.
204 | Success | The server sucessfully processed the request, but no contacts were found.
400 | Error | Child with the specified ID could not be found in the database.

**Example Response**

```
[
  {
    "id": 1,
    "contactable_id": 2,
    "contactable_type": "Child",
    "first_name": "Luchador",
    "last_name": "Libre",
    "relationship": "Uncle",
    "address": null,
    "phone_number": "800-555-5555",
    "alternate_number": null
  },
  {
    "id": 2,
    "contactable_id": 2,
    "contactable_type": "Child",
    "first_name": "Lochadora",
    "last_name": "Libre",
    "relationship": "Aunt",
    "address": "1234 Fake Street, City, GA, 30000",
    "phone_number": "800-111-1111",
    "alternate_number": "777-777-7777"
  }
]
```

#### Contact Index for a User

List of all contacts that are associated with a specified user. *Note:* The contactable_type is the type of model that the contact belongs to. The contactable_id is the ID number of the Child/User in which the contact belongs to.

Path:
`GET '/user/:username/contacts'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | All contacts were successfully returned.
204 | Success | The server sucessfully processed the request, but no contacts were found.
400 | Error | User with the specified username could not be found in the database.

**Example Response**

```
[
  {
    "id": 1,
    "contactable_id": 2,
    "contactable_type": "User",
    "first_name": "Luchador",
    "last_name": "Libre",
    "relationship": "Uncle",
    "address": null,
    "phone_number": "800-555-5555",
    "alternate_number": null
  },
  {
    "id": 2,
    "contactable_id": 2,
    "contactable_type": "User",
    "first_name": "Lochadora",
    "last_name": "Libre",
    "relationship": "Aunt",
    "address": "1234 Fake Street, City, GA, 30000",
    "phone_number": "800-111-1111",
    "alternate_number": "777-777-7777"
  }
]
```

#### Create Contact for Child

Creates a contact for a specified child.

Path: 
`POST '/child/:id/contacts'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Contact's first name.
last_name | string | **Required.** Contact's last name.
relationship | string | **Required.** Contact's relation to the child.
address | string | Contact's home/work address.
phone_number | string | **Required.** Contact's primary phone number to contact in case of emergency.
alternate_number | string | An alternate phone number in which the contact can be reached.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Contact for the specified child was created successfully.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "phone_number": "800-555-5555"
}
```

**Example Response**

```
{
  "id": 1,
  "contactable_id": 2,
  "contactable_type": "Child",
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "address": null,
  "phone_number": "800-555-5555",
  "alternate_number": null
}
```

#### Create Contact for User

Creates a contact for the user that is currently logged in.

Path: 
`POST 'users/contacts'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | **Required.** Contact's first name.
last_name | string | **Required.** Contact's last name.
relationship | string | **Required.** Contact's relation to the child.
address | string | Contact's home/work address.
phone_number | string | **Required.** Contact's primary phone number to contact in case of emergency.
alternate_number | string | An alternate phone number in which the contact can be reached.

**Status Codes**

Code | Type | Description
---|---|---
201 | Success | Contact for the specified user was created successfully.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "phone_number": "800-555-5555"
}
```

**Example Response**

```
{
  "id": 1,
  "contactable_id": 2,
  "contactable_type": "User",
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "address": null,
  "phone_number": "800-555-5555",
  "alternate_number": null
}
```

#### Update Contact

Updates the contact information for a specified contact.

Path:
`PUT '/contact/:id'`

**Parameters**

Name | Type | Description
--- | --- | ---
first_name | string | Contact's first name.
last_name | string | Contact's last name.
relationship | string | Contact's relation to the child.
address | string | Contact's home/work address.
phone_number | string | Contact's primary phone number to contact in case of emergency.
alternate_number | string | An alternate phone number in which the contact can be reached.

**Status Codes**

Code | Type | Description
---|---|---
200 | Success | Contact was successfully updated.
422 | Error | Unprocessable Entry. Specified parameters are invalid.

**Example Input**

```
{
  "phone_number": "800-555-9999",
  "alternate_number": "999-999-9999"
}
```

**Example Response**

```
{
  "id": 1,
  "contactable_id": 2,
  "contactable_type": "User",
  "first_name": "Luchador",
  "last_name": "Libre",
  "relationship": "Uncle",
  "address": null,
  "phone_number": "800-555-9999",
  "alternate_number": "999-999-9999"
}
```

#### Delete Contact

Deletes the contact information for a specifed contact.

Path:
`DELETE '/contact/:id'`

**Parameters**
*None*

**Status Codes**

Code | Type | Description
---|---|---
204 | Success | Request was received and deleted successfully.
400 | Error | Bad Request. Specified parameters do not match.
401 | Error | Unauthorized. A different user is not authorized to delete another user's contacts.
