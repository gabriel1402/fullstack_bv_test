import { Component, OnInit } from '@angular/core';
import { UrlService } from '../services/url.service';
import { enterLeft } from '../animations/router.animations';

@Component({
  selector: 'app-url-shortener',
  templateUrl: './url-shortener.component.html',
  styleUrls: ['./url-shortener.component.scss'],
  animations: [ enterLeft() ]
})
export class UrlShortenerComponent implements OnInit {
  url:string = '';
  shortUrl:string;
  errors:any;

  constructor(private urlService: UrlService) { }

  ngOnInit() {
  }

  getShortUrl() {
    this.urlService.shortUrl(this.url).then(res => {
      if (res && res['status'] == 'success') {
        this.shortUrl = res['data'];
      }
    }).catch(err => {
      this.errors = err.error.errors
    })
  }

  clear() {
    this.url = '';
    this.shortUrl = '';
    this.errors = [];
  }

  copy(){
    let selBox = document.createElement('textarea');
      selBox.style.position = 'fixed';
      selBox.style.left = '0';
      selBox.style.top = '0';
      selBox.style.opacity = '0';
      selBox.value = this.shortUrl;
      document.body.appendChild(selBox);
      selBox.focus();
      selBox.select();
      document.execCommand('copy');
      document.body.removeChild(selBox);
    }

}
