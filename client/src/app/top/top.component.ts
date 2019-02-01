import { Component, OnInit } from '@angular/core';
import { UrlService } from '../services/url.service';
import { enterRight } from '../animations/router.animations';

@Component({
  selector: 'app-top',
  templateUrl: './top.component.html',
  styleUrls: ['./top.component.scss'],
  animations: [ enterRight() ]
})
export class TopComponent implements OnInit {

  top_urls = [];
  error:any;
  loading:boolean;

  constructor(private service: UrlService) { }

  ngOnInit() {
    this.loading = true;
    this.service.top().then(res => {
      if (res && res['status'] == 'success') {
        this.top_urls = res['data'];
        return;
      }
    }).catch(err => {
      this.error = err;
    }).finally(() => {
      this.loading = false;
    })
  }

}
