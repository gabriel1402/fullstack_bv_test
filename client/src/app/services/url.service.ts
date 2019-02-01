import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UrlService {
  private baseUrl = environment.api_url;

  constructor(private http: HttpClient) { }

  shortUrl(url: string) {
    return this.http.post(`${this.baseUrl}url`, {url: url}).toPromise();
  }

  top() {
    return this.http.get(`${this.baseUrl}top`).toPromise();
  }

}
