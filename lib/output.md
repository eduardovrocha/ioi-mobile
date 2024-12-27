# files total: 22

Total lines across all files: 7140

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">balance_data.dart - 34 lines</summary>

- **Functions Count**: 0

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 3</summary>

- Content: Construtor (Line: 5)
- Content: Método para converter JSON em um objeto Balance (Line: 6)
- Content: Método para converter o objeto Balance em JSON (Line: 7)
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">exemple_data.dart - 185 lines</summary>

- **Functions Count**: 5

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 3</summary>

- Content: 7 lines
- Content: 6 lines
- Content: 7 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 3</summary>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: ProfileData.fromJson</summary>

- **Name**: ProfileData.fromJson
- **Description**: Factory method to parse JSON data into a ProfileData object. Validates the presence of required fields and initializes nested objects.
- **Signature**:
  - **Type**: Map<String, dynamic> json
  - **TextTest**: null
  - **ValueTest**: null
- **Return**: ProfileData

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: printProfileData</summary>

- **Name**: printProfileData
- **Description**: Method to print the accessible content of the ProfileData instance, including its nested objects.
- **Signature**:
- **Return**: 

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: Presences.fromJson</summary>

- **Name**: Presences.fromJson
- **Description**: Factory method to parse JSON data into a Presences object with nested PresenceStatus for professional and personal fields.
- **Signature**:
  - **Type**: Map<String, dynamic> json
  - **TextTest**: null
  - **ValueTest**: null
- **Return**: Presences

</details>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">profile_data.dart - 234 lines</summary>

- **Functions Count**: 5

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 6</summary>

- Content: 7 lines
- Content: 6 lines
- Content: 7 lines
- Content: 6 lines
- Content: 7 lines
- Content: 7 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 6</summary>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: ProfileData.fromJson</summary>

- **Name**: ProfileData.fromJson
- **Description**: Factory method to parse JSON data into a ProfileData object. Validates the presence of required fields and initializes nested objects.
- **Signature**:
  - **Type**: Map<String, dynamic> json
  - **TextTest**: null
  - **ValueTest**: null
- **Return**: ProfileData

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: printProfileData</summary>

- **Name**: printProfileData
- **Description**: print the accessible content of the ProfileData instance
- **Signature**:
- **Return**: 

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: Vouchers.fromJson</summary>

- **Name**: Vouchers.fromJson
- **Description**: Factory method to parse JSON data into a Vouchers object. Converts each numeric field from JSON with validation to ensure valid integers.
- **Signature**:
  - **Type**: Map<String, dynamic> json
  - **TextTest**: null
  - **ValueTest**: null
- **Return**: Vouchers

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: printPresences</summary>

- **Name**: printPresences
- **Description**: Prints the details of professional and personal presences, including doc, doc_type, and activation details.
- **Signature**:
- **Return**: void

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: Tokens.fromJson</summary>

- **Name**: Tokens.fromJson
- **Description**: Factory method to parse JSON data into a Tokens object. Converts amount to a string and collected to a double, ensuring default values if fields are missing or invalid.
- **Signature**:
  - **Type**: Map<String, dynamic> json
  - **TextTest**: null
  - **ValueTest**: null
- **Return**: Tokens

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: Currency.fromJson</summary>

- **Name**: Currency.fromJson
- **Description**: Factory method to parse JSON data into a Currency object. Ensures amount is a string with a default value if data is missing or invalid.
- **Signature**:
  - **Type**: Map<String, dynamic> json
  - **TextTest**: null
  - **ValueTest**: null
- **Return**: Currency

</details>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">api_service.dart - 515 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 45</summary>

- Content: [new][not-tested]
- Content: throw Exception('Failed to load received notes'); (Line: 79)
- Content: var jsonResponse = json.decode(response.body); /* Convert response body to a map
- Content: Extract the 'id' from the response (Line: 82)
- Content: await setProfileId(balanceId); (Line: 83)
- Content: [new][not-tested]
- Content: throw Exception('Failed to load received notes'); (Line: 79)
- Content: [new][not-tested]
- Content: throw Exception('Failed to load received notes'); (Line: 79)
- Content: [new][not-tested]
- Content: [new][not-tested]
- Content: [new][not-tested]
- Content: [revised][tested]
- Content: print('Received Note created successfully!'); (Line: 92)
- Content: 2 lines
- Content: print('Error creating Received Note: $e');
- Content: [revised]
- Content: o corpo da requisição está em JSON (Line: 96)
- Content: Convert response body to a map (Line: 97)
- Content: Extract the 'id' from the response (Line: 82)
- Content: [revised]
- Content: [revised]
- Content: print(response.body); (Line: 101)
- Content: [revised]
- Content: print(profileId); (Line: 103)
- Content: print(uniqueId); (Line: 104)
- Content: 0 lines
- Content: if (responseBody != null) { (Line: 106)
- Content: [revised]
- Content: [revised]
- Content: [new]
- Content: 4 lines
- Content: 3 lines
- Content: /* Exemplo de funções que podem ser chamadas
- Content: Simulação de chamada à API (Line: 113)
- Content: manage profile presence (Line: 114)
- Content: manage profile presence (Line: 114)
- Content: manage profile presence (Line: 114)
- Content: manage profile presence (Line: 114)
- Content: print("presence_${presencetype}: ${profilePresence}");
- Content: manage profile presence (Line: 114)
- Content: manage profile presence (Line: 114)
- Content: print(prefs.getString("presence_${presenceType}")?.isNotEmpty); (Line: 121)
- Content: manage profile presence (Line: 114)
- Content: 36 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">collects_view.dart - 311 lines</summary>

- **Functions Count**: 4

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 4</summary>

- Content: 7 lines
- Content: pre sale advertise (Line: 129)
- Content: section info show (Line: 130)
- Content: received tokens ($MC3) (Line: 131)
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">coming_binds_view.dart - 177 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 4</summary>

- Content: Coming Bind Header (Line: 136)
- Content: centraliza horizontal (Line: 137)
- Content: 6 lines
- Content: null
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">configurations_view.dart - 327 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 4</summary>

- Content: 6 lines
- Content: MainAxisAlignment.spaceAround (Line: 145)
- Content: 3 lines
- Content: 3 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">received_notes_view.dart - 442 lines</summary>

- **Functions Count**: 6

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 13</summary>

- Content: 3 lines
- Content: 2 lines
- Content: 3 lines
- Content: default value (Line: 155)
- Content: open QR code when click on "Vouchers" (Line: 156)
- Content: main content (Line: 157)
- Content: 7 lines
- Content: Open the drawer (Line: 159)
- Content: app main bar (Line: 160)
- Content: sub title space (Line: 161)
- Content: header (Line: 162)
- Content: color: Color(0xFFFED86A),
- Content: null
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">transactions_view.dart - 88 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 1</summary>

- Content: endDrawer: _buildRightDrawer(context),
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">campaign_item_widget.dart - 263 lines</summary>

- **Functions Count**: 2

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 4</summary>

- Content: 0 lines
- Content: 0 lines
- Content: Distribui o espaço igualmente entre os itens (Line: 176)
- Content: 22 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">collect_list_widget.dart - 566 lines</summary>

- **Functions Count**: 4

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 16</summary>

- Content: funcional (Line: 182)
- Content: 3 lines
- Content: 3 lines
- Content: _scrollController.dispose(); (Line: 185)
- Content: 7 lines
- Content: 11 lines
- Content: controller: _scrollController,
- Content: dynamic bottom border (Line: 189)
- Content: align content (Line: 190)
- Content: Segunda coluna com ícone e texto (Line: 191)
- Content: 12 lines
- Content: background vertical line width (Line: 193)
- Content: version 1.0.1 (Line: 194)
- Content: 8 lines
- Content: 194 lines
- Content: 8 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">coming_bind_list_widget.dart - 255 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 3</summary>

- Content: funcional (Line: 182)
- Content: version 1.0.1 (Line: 194)
- Content: 8 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">content_activation_form_widget.dart - 364 lines</summary>

- **Functions Count**: 8

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 11</summary>

- Content: model data Presence (Line: 209)
- Content: 9 lines
- Content: find's on presences array the element with received doc_type (Line: 211)
- Content: profilePresences should be already in storage identifation (Line: 212)
- Content: 7 lines
- Content: height size adapted by child height size (Line: 214)
- Content: close activation dialog (Line: 215)
- Content: change to 'error' to test (Line: 216)
- Content: change to 'error' to test (Line: 216)
- Content: 2 lines
- Content: 3 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">content_campaign_form_widget.dart - 859 lines</summary>

- **Functions Count**: 14

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 11</summary>

- Content: final _allocatedController = MaskedTextController(mask: '000.000.000,00000');
- Content: _allocatedController.addListener(_formatInput); (Line: 225)
- Content: _allocatedController.removeListener(_formatInput); (Line: 226)
- Content: 0 lines
- Content: 0 lines
- Content: const SendButton() (Line: 229)
- Content: 0 lines
- Content: 0 lines
- Content: 3 lines
- Content: 0 lines
- Content: sendButton (Line: 234)
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">content_configuration_form_widget.dart - 1401 lines</summary>

- **Functions Count**: 26

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 17</summary>

- Content: 9 lines
- Content: Update the UI if this is in a StatefulWidget (Line: 240)
- Content: 6 lines
- Content: 6 lines
- Content: 6 lines
- Content: 6 lines
- Content: 6 lines
- Content: find's on presences array the element with received doc_type (Line: 211)
- Content: height size adapted by child height size (Line: 214)
- Content: 0 lines
- Content: select profile configuration doc_type (Line: 249)
- Content: 3 lines
- Content: professional profile - cnpj (Line: 251)
- Content: const SendButton() (Line: 229)
- Content: professional profile - contact name (Line: 253)
- Content: professional profile - whatsapp phone contact (Line: 254)
- Content: action(); (Line: 255)
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 5</summary>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: checkCNPJ</summary>

- **Name**: checkCNPJ
- **Description**: verify if presences has professional id
- **Signature**:
- **Return**: 

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: checkPassport</summary>

- **Name**: checkPassport
- **Description**: verify if presences has personal id
- **Signature**:
- **Return**: 

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: checkDriveLicense</summary>

- **Name**: checkDriveLicense
- **Description**: verify if presences has personal id
- **Signature**:
- **Return**: 

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: checkCPF</summary>

- **Name**: checkCPF
- **Description**: verify if presences has personal id
- **Signature**:
- **Return**: 

</details>

<details style="font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px">
<summary>name: isValidCNPJ</summary>

- **Name**: isValidCNPJ
- **Description**: verify consistency for "CNPJ" field
- **Signature**:
- **Return**: 

</details>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">custom_snackbar_widget.dart - 119 lines</summary>

- **Functions Count**: 2

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 1</summary>

- Content: 14 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">modal_activation_proffesional_account_form_widget.dart - 110 lines</summary>

- **Functions Count**: 1

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 2</summary>

- Content: content for App Configuration & Business Activation (Line: 280)
- Content: ContentConfigurationFormWidget(profilePresences) (Line: 281)
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">modal_configuration_form_widget.dart - 57 lines</summary>

- **Functions Count**: 1

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 1</summary>

- Content: child: ContentConfigurationFormWidget(profilePresences),
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">received_note_list_widget.dart - 309 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 8</summary>

- Content: funcional (Line: 182)
- Content: Declare the parameter (Line: 292)
- Content: print(screenSize); (Line: 293)
- Content: final meta = snapshot.data!['meta'] as Map<String, dynamic>; (Line: 294)
- Content: 26 lines
- Content: 3 lines
- Content: version 1.0.1 (Line: 194)
- Content: 8 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">splash_screen_widget.dart - 119 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 1</summary>

- Content: 9 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">update_profile_screen_widget.dart - 141 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 5</summary>

- Content: 9 lines
- Content: checkprofile (Line: 309)
- Content: 3 lines
- Content: image to show (Line: 311)
- Content: 6 lines
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px">welcome_widget.dart - 264 lines</summary>

- **Functions Count**: 3

<details>
<summary style="margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px">notations 2</summary>

- Content: Generate a new UUID (Line: 317)
- Content: Store it locally (Line: 318)
</details>


<details style="margin-bottom: 10px;">
<summary style="font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px">documented 0</summary>

</details>


</details>


