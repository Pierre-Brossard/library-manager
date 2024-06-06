import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="manga-api-connect"
export default class extends Controller {
  creds = {
    grant_type: 'password',
    username: 'hidroyd',
    password: '#a*7NEA^j3Q^u9',
    client_id: 'personal-client-e4c4220a-f785-4121-a30c-61aa61fc53a4-4283a005',
    client_secret: 'UE7kWQDMglcdZyIeBYR2ppz0vnDkIp5T',
  };

  url =
    'https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/token';

  connect() {}

  testLogApi() {
    fetch(this.url, {
      method: 'POST',
      mode: 'cors',
      headers: {
        'User-Agent': navigator.userAgent,
        'Content-type': 'application/x-www-form-urlencoded',
      },
      body: this.creds,
    }).then((response) => console.log(response));
  }
}
