import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UrlShortenerComponent } from './url-shortener/url-shortener.component';
import { TopComponent } from './top/top.component';

const routes: Routes = [
  { path: '', component: UrlShortenerComponent },
  { path: 'top', component: TopComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
