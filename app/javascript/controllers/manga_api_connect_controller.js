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

  mangaDexConnection;

  //? wrapp app.erb avec ce controller et stocker les donnee piur ne pas request token a chaque chargement de la page
  connect() {
    if (this.mangaDexConnection) {
      console.log('conecter');
    } else {
      this.mangaDexConnection = this.#testLogApi();
    }
  }

  #testLogApi() {
    const formBody = Object.keys(this.creds)
      .map(
        (key) =>
          encodeURIComponent(key) + '=' + encodeURIComponent(this.creds[key])
      )
      .join('&');

    fetch(this.url, {
      method: 'POST',
      headers: {
        'User-Agent': navigator.userAgent,
        'Content-type': 'application/x-www-form-urlencoded',
      },
      body: formBody,
    }).then((response) =>
      response.json().then((data) => {
        console.log(data);

        return {
          access_token: data.access_token,
          access_expire: data.expires_in,
          refresh_token: data.refresh_token,
          refresh_expire: data.refresh_expires_in,
        };
      })
    );
  }
}
