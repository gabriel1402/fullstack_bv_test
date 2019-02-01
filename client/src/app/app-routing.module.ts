import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UrlShortenerComponent } from './url-shortener/url-shortener.component';
import { TopComponent } from './top/top.component';

const routes: Routes = [
  { path: '', component: UrlShortenerComponent, data: {animation: "UrlPage"} },
  { path: 'top', component: TopComponent, data: {animation: "TopPage"} }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
