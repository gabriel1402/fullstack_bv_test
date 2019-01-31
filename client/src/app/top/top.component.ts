import { Component, OnInit } from '@angular/core';
import { UrlService } from '../services/url.service';

@Component({
  selector: 'app-top',
  templateUrl: './top.component.html',
  styleUrls: ['./top.component.scss']
})
export class TopComponent implements OnInit {

  top_urls = [];

  constructor(private service: UrlService) { }

  ngOnInit() {
    this.service.top().then(res => {
      if (res && res['status'] == 'success') {
        this.top_urls = res['data'];
      }
    })
  }

}
