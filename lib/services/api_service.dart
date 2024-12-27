import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mrcatcash/models/profile_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  final String baseUrl = 'http://192.168.12.184:3020';

  /* [new][not-tested] */
  Future<String> createBalance(Map<String, dynamic> data) async {
    try {
      String? profileId = await getProfileId();
      final body = jsonEncode({
        "balance": data
      });
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '', // Use empty string if profileId is null
      };
      final response = await http.post(Uri.parse('$baseUrl/balances'),
          headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['balances']['data'] ?? [];
        final responseMeta = responseBody['balances']['meta'] ?? {};


        return responseData[0]['id'];
      } else {
        /* throw Exception('Failed to load received notes'); */
        return 'null';
      }
    } catch (e) {
      throw Exception('Error fetching presences: $e');
    }

    /* var jsonResponse = json.decode(response.body); /* Convert response body to a map */
    print(jsonResponse);

    var balanceId = jsonResponse['id']; /* Extract the 'id' from the response */

    if (balanceId != null) {
      /* await setProfileId(balanceId); */

      return balanceId;
    } else {

      return 'null';
    } */
  }

  /* [new][not-tested] */
  Future<String> createCampaign(Map<String, dynamic> data) async {
    try {
      String? profileId = await getProfileId();
      final body = jsonEncode({
        "campaign": data
      });
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '', // Use empty string if profileId is null
      };
      final response = await http.post(Uri.parse('$baseUrl/campaigns'),
          headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['campaigns']['data'] ?? [];
        final responseMeta = responseBody['campaigns']['meta'] ?? {};

        return responseData[0]['id'];
      } else {
        /* throw Exception('Failed to load received notes'); */
        return 'null';
      }
    } catch (e) {
      throw Exception('Error fetching presences: $e');
    }
  }

  /* [new][not-tested] */
  Future<String> createPresence(Map<String, dynamic> data) async {
    try {
      String? profileId = await getProfileId();
      final body = jsonEncode({
        "presence": data
      });
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '', // Use empty string if profileId is null
      };
      final response = await http.post(Uri.parse('$baseUrl/presences'),
          headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        

        final responseData = responseBody['presences']['data'] ?? [];
        final responseMeta = responseBody['presences']['meta'] ?? {};

        return responseData[0]['id'];
      } else {
        /* throw Exception('Failed to load received notes'); */
        return 'null';
      }
    } catch (e) {
      throw Exception('Error fetching presences: $e');
    }
  }

  /* [new][not-tested] */
  Future<String> updateActivation(Map<String, dynamic> data) async {
    try {
      String? profileId = await getProfileId();
      final body = jsonEncode({
        "activation": data
      });
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '', // Use empty string if profileId is null
      };
      final response = await http.post(Uri.parse
        ('$baseUrl/activations/set_active'),
          headers: headers, body: body);

      final activation = json.decode(response.body);

      if (response.statusCode == 200) {

        return "success";
      } else {

        return "error";
      }
    } catch (e) {
      throw Exception('Error fetching presences: $e');
    }
  }

  /* [new][not-tested] */
  Future<Map<String, dynamic>> fetchPresences() async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',
      };
      final response = await http.get(
        Uri.parse('$baseUrl/presences'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['presences']['data'] ?? [];
        final responseMeta = responseBody['presences']['meta'] ?? {};

        return {
          'data': responseData is List ? responseData : [responseData],
          'meta': responseMeta,
        };
      } else {
        throw Exception('Failed to load presences');
      }
    } catch (e) {
      throw Exception('Error fetching presences: $e');
    }
  }

  /* [new][not-tested] */
  Future<Map<String, dynamic>> fetchBalances() async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',  // Use empty string if profileId is null
      };
      final response = await http.get(
        Uri.parse('$baseUrl/balances'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['balances']['data'] ?? [];
        final responseMeta = responseBody['balances']['meta'] ?? {};

        return {
          'data': responseData is List ? responseData : [responseData],  // Ensure data is always a List
          'meta': responseMeta,  // Meta information
        };
      } else {
        throw Exception('Failed to load presences');
      }
    } catch (e) {
      throw Exception('Error fetching presences: $e');
    }
  }

  /* [revised][tested] */
  Future<void> createReceivedNote(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/received_notes');
    final headers = {
      'Content-Type': 'application/json',  // Indicating the body is in JSON format
    };
    final body = jsonEncode(data);

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        /*  */
      } else {
        /* 
        /*  */ */
      }
    } catch (e) {
      /*  */
    }
  }

  /* [revised] */
  Future<String> createProfile(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/profiles');
    final body = jsonEncode({"profile": { "uniqueId": data }});
    final response = await http.post(
      url, headers: {
      'Content-Type': 'application/json',  /* o corpo da requisição está em JSON */
    }, body: body,
    );

    var jsonResponse = json.decode(response.body); /* Convert response body to a map */
    var profileId = jsonResponse['id']; /* Extract the 'id' from the response */

    if (profileId != null) {
      await setProfileId(profileId);

      return profileId;
    } else {

      return 'null';
    }
  }

  /* [revised] */
  Future<Map<String, dynamic>> fetchReceivedNotes() async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',  // Use empty string if profileId is null
      };
      final response = await http.get(
        Uri.parse('$baseUrl/received_notes'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['received_notes']['data'] ?? [];
        final responseMeta = responseBody['received_notes']['meta'] ?? {};
        return {
          'data': responseData is List ? responseData : [responseData],  // Ensure data is always a List
          'meta': responseMeta,  // Meta information
        };
      } else {
        throw Exception('Failed to load received notes');
      }
    } catch (e) {
      throw Exception('Error fetching received notes: $e');
    }
  }

  /* [revised] */
  Future<Map<String, dynamic>> fetchComingBinds() async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',  // Use empty string if profileId is null
      };
      final response = await http.get(
        Uri.parse('$baseUrl/coming_binds'),
        headers: headers,
      );
      /* print(response.body); */
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        final responseData = responseBody['coming_binds']['data'] ?? [];
        final responseMeta = responseBody['coming_binds']['meta'] ?? {};
        return {
          'data': responseData is List ? responseData : [responseData],  // Ensure data is always a List
          'meta': responseMeta,  // Meta information
        };
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw Exception('Error fetching received notes: $e');
    }
  }

  /* [revised] */
  Future<ProfileData> fetchProfileData() async {
    String? profileId = await getProfileId();
    String? uniqueId = await getUniqueId();

    final headers = {
      'Content-Type': 'application/json',
      'profileId': profileId ?? '',  // Use empty string if profileId is null
    };
    final response = await http.get(
      Uri.parse('$baseUrl/profiles/${profileId ?? ''}'),
      headers: headers,
    );

    // Extract the data from the response (ensure it’s a List)
    final responseBody = json.decode(response.body);
    final responseStatus = json.decode(response.statusCode.toString()); /**/

    print("---> on lib/services/api_service");
    print(responseBody['profile']['data']['attributes']);
    print(responseStatus);
    print('--->');

    if (responseStatus == 200) {
      final attributesToMap = responseBody['profile']['data']['attributes'];

      final personalActivation = attributesToMap['presences']['personal']['activation'];
      final professionalActivation = attributesToMap['presences']['professional']['activation'];

      print("personal activation: $personalActivation");
      print("professional activation: $professionalActivation");
      print("--->");

      return ProfileData.fromJson(attributesToMap);
    } else {
      return throw Exception('Profile data is empty');
    }
  }

  /* [revised] */
  Future<Map<String, dynamic>> fetchCollects() async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',  // Use empty string if profileId is null
      };
      final response = await http.get(
        Uri.parse('$baseUrl/collects'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        final responseData = responseBody['collects']['data'] ?? [];
        final responseMeta = responseBody['collects']['meta'] ?? {};
        return {
          'data': responseData is List ? responseData : [responseData],  // Ensure data is always a List
          'meta': responseMeta,  // Meta information
        };
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw Exception('Error fetching collects: $e');
    }
  }

  /* [refact.] */
  /* [background jobs selection ] */
  Future<String> fetchJobsExecution(String jobName) async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',  // Use empty string if profileId is null
        'jobName': jobName
      };
      final response = await http.get(
        Uri.parse('$baseUrl/last_job_execution.json'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        String nexExecutionSchedule = responseBody['next_execution_in'];

        return nexExecutionSchedule;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch(e) {
      throw Exception('Error fetching collects: $e');
    }
  }
  /* [background jobs selection ] */
  fetchJobExecutions(String jobName) async {
    String jobNameExecution = await fetchJobsExecution(jobName);

    return jobNameExecution;
  }
  /* [refact.] */

  /* [revised] */
  Future<Map<String, dynamic>> fetchShards(String jobName) async {
    try {
      String? profileId = await getProfileId();
      final headers = {
        'Content-Type': 'application/json',
        'profileId': profileId ?? '',  // Use empty string if profileId is null
        'jobName': jobName
      };
      final response = await http.get(
        Uri.parse('$baseUrl/last_job_execution.json'),
        headers: headers,
      );

      print('\n\nresponse code: ${response.statusCode}');
      print('response body: ${response.body}\n\n');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody ?? [];

        /*
          final responseMeta = responseBody ?? {};
        */
        return {
          'data': responseData is List ? responseData : [responseData],
          /* 'meta': responseMeta */
        };
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw Exception('Error fetching collects: $e');
    }
  }

  /* [new] */
  Future<String> callFunction(String functionName, Map<String, dynamic> data) async {
    switch (functionName) {
      /* case 'sendData':
        return await sendData(data);
      case 'updateData':
        return await updateData(data); */ /*
        add more functions paths by you needs
      */
      case 'createAppConfigPersonal':
        return await createPresence(data);
      case 'createAppConfigProfessional':
        return await createPresence(data);
      default:
        throw Exception('Função $functionName não encontrada na ApiService');
    }
  }

  /* /* Exemplo de funções que podem ser chamadas */
  Future<String> sendData(Map<String, dynamic> data) async {
    /* Simulação de chamada à API */
    await Future.delayed(const Duration(seconds: 2));
    return 'success'; // Retorna 'success' ou qualquer outro resultado baseado na resposta da API
  }

  Future<String> updateData(Map<String, dynamic> data) async {
    // Simulação de chamada à API
    await Future.delayed(const Duration(seconds: 2));
    return 'error'; // Retorna 'error' ou outro resultado conforme a resposta da API
  } */

  /* manage profile presence */
  getUniqueId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('unique_id');
  }

  /* manage profile presence */
  getProfileId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('profile_id');
  }

  /* manage profile presence */
  setProfileId(profileId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_id', profileId);
  }

  /* manage profile presence */
  setProfilePresence(profilePresence) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> elements = profilePresence.split(',');
    String presencetype = '';
    if (elements.length > 3) {
      presencetype = elements[3].trim().toLowerCase();
      /**/
      prefs.setString("presence_${presencetype}", profilePresence);
    }
  }

  /* manage profile presence */
  getPresence(presenceType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("presence_${presenceType}");
  }

  /* manage profile presence */
  profileGotPresence(presenceType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /*print(prefs.getString("presence_${presenceType}")?.isNotEmpty);*/
    print(prefs.getString("presence_${presenceType}"));

    return prefs.getString("presence_${presenceType}")?.isNotEmpty;
  }

  /* manage profile presence */
  cleanPresence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  /* [old stuff]
  Future<List<dynamic>> fetchRealizedBinds() async {
    final response = await http.get(Uri.parse('$baseUrl/realized_binds'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse is List) {

        return jsonResponse; // Return the list directly
      } else if (jsonResponse is Map) {

        return [jsonResponse]; // Wrap the single object in a list
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load received notes');
    }
  }
  Future<List<dynamic>> fetchTransactionsHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/transaction_Histories'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse is List) {

        return jsonResponse; // Return the list directly
      } else if (jsonResponse is Map) {

        return [jsonResponse]; // Wrap the single object in a list
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load received notes');
    }
  }
  * */

}
