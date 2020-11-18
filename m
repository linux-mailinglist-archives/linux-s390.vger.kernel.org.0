Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA402B7B51
	for <lists+linux-s390@lfdr.de>; Wed, 18 Nov 2020 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgKRKaq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Nov 2020 05:30:46 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:30988 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKRKaq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1605695440; x=1637231440;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VJ7lKzudxsMHhPcYhcSWeH76B5FDWJujFpu0MImshQ4=;
  b=YbY3xdLcJthkYXvb4MMjt1EtLo1QJMdbtCm/7btyd4jIqWwmkKOUjRuB
   mNradqDXZzKdp2xvbaymU6Xbo25G4Mz4FcW/gbaAPVqwIJ5Y6DHnB4Ngd
   KzzvZStuzn08APB1eSM2aVQZqWZDsmgtnHSd/WOsusI4G91IV9pKXFLCN
   8=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="67144022"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Nov 2020 10:30:29 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 8A722A205E;
        Wed, 18 Nov 2020 10:30:19 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 10:30:18 +0000
Received: from Alexanders-MacBook-Air.local (10.43.162.146) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 10:30:10 +0000
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
To:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>
CC:     Willy Tarreau <w@1wt.eu>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric Biggers" <ebiggers@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "oridgar@gmail.com" <oridgar@gmail.com>,
        "ghammer@redhat.com" <ghammer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Qemu Developers" <qemu-devel@nongnu.org>,
        KVM list <kvm@vger.kernel.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        Linux API <linux-api@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "areber@redhat.com" <areber@redhat.com>,
        "Pavel Emelyanov" <ovzxemul@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
        "gil@azul.com" <gil@azul.com>,
        "asmehra@redhat.com" <asmehra@redhat.com>,
        "dgunigun@redhat.com" <dgunigun@redhat.com>,
        "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
From:   Alexander Graf <graf@amazon.de>
Message-ID: <f78a0a2f-d26a-6b50-c252-b4610e5f8273@amazon.de>
Date:   Wed, 18 Nov 2020 11:30:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.146]
X-ClientProxiedBy: EX13P01UWB004.ant.amazon.com (10.43.161.213) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

CgpPbiAxNi4xMS4yMCAxNjozNCwgQ2F0YW5naXUsIEFkcmlhbiBDb3N0aW4gd3JvdGU6Cj4gLSBC
YWNrZ3JvdW5kCj4gCj4gVGhlIFZNIEdlbmVyYXRpb24gSUQgaXMgYSBmZWF0dXJlIGRlZmluZWQg
YnkgTWljcm9zb2Z0IChwYXBlcjoKPiBodHRwOi8vZ28ubWljcm9zb2Z0LmNvbS9md2xpbmsvP0xp
bmtJZD0yNjA3MDkpIGFuZCBzdXBwb3J0ZWQgYnkKPiBtdWx0aXBsZSBoeXBlcnZpc29yIHZlbmRv
cnMuCj4gCj4gVGhlIGZlYXR1cmUgaXMgcmVxdWlyZWQgaW4gdmlydHVhbGl6ZWQgZW52aXJvbm1l
bnRzIGJ5IGFwcHMgdGhhdCB3b3JrCj4gd2l0aCBsb2NhbCBjb3BpZXMvY2FjaGVzIG9mIHdvcmxk
LXVuaXF1ZSBkYXRhIHN1Y2ggYXMgcmFuZG9tIHZhbHVlcywKPiB1dWlkcywgbW9ub3RvbmljYWxs
eSBpbmNyZWFzaW5nIGNvdW50ZXJzLCBldGMuCj4gU3VjaCBhcHBzIGNhbiBiZSBuZWdhdGl2ZWx5
IGFmZmVjdGVkIGJ5IFZNIHNuYXBzaG90dGluZyB3aGVuIHRoZSBWTQo+IGlzIGVpdGhlciBjbG9u
ZWQgb3IgcmV0dXJuZWQgdG8gYW4gZWFybGllciBwb2ludCBpbiB0aW1lLgo+IAo+IFRoZSBWTSBH
ZW5lcmF0aW9uIElEIGlzIGEgc2ltcGxlIGNvbmNlcHQgbWVhbnQgdG8gYWxsZXZpYXRlIHRoZSBp
c3N1ZQo+IGJ5IHByb3ZpZGluZyBhIHVuaXF1ZSBJRCB0aGF0IGNoYW5nZXMgZWFjaCB0aW1lIHRo
ZSBWTSBpcyByZXN0b3JlZAo+IGZyb20gYSBzbmFwc2hvdC4gVGhlIGh3IHByb3ZpZGVkIFVVSUQg
dmFsdWUgY2FuIGJlIHVzZWQgdG8KPiBkaWZmZXJlbnRpYXRlIGJldHdlZW4gVk1zIG9yIGRpZmZl
cmVudCBnZW5lcmF0aW9ucyBvZiB0aGUgc2FtZSBWTS4KPiAKPiAtIFByb2JsZW0KPiAKPiBUaGUg
Vk0gR2VuZXJhdGlvbiBJRCBpcyBleHBvc2VkIHRocm91Z2ggYW4gQUNQSSBkZXZpY2UgYnkgbXVs
dGlwbGUKPiBoeXBlcnZpc29yIHZlbmRvcnMgYnV0IG5laXRoZXIgdGhlIHZlbmRvcnMgb3IgdXBz
dHJlYW0gTGludXggaGF2ZSBubwo+IGRlZmF1bHQgZHJpdmVyIGZvciBpdCBsZWF2aW5nIHVzZXJz
IHRvIGZlbmQgZm9yIHRoZW1zZWx2ZXMuCj4gCj4gRnVydGhlcm1vcmUsIHNpbXBseSBmaW5kaW5n
IG91dCBhYm91dCBhIFZNIGdlbmVyYXRpb24gY2hhbmdlIGlzIG9ubHkKPiB0aGUgc3RhcnRpbmcg
cG9pbnQgb2YgYSBwcm9jZXNzIHRvIHJlbmV3IGludGVybmFsIHN0YXRlcyBvZiBwb3NzaWJseQo+
IG11bHRpcGxlIGFwcGxpY2F0aW9ucyBhY3Jvc3MgdGhlIHN5c3RlbS4gVGhpcyBwcm9jZXNzIGNv
dWxkIGJlbmVmaXQKPiBmcm9tIGEgZHJpdmVyIHRoYXQgcHJvdmlkZXMgYW4gaW50ZXJmYWNlIHRo
cm91Z2ggd2hpY2ggb3JjaGVzdHJhdGlvbgo+IGNhbiBiZSBlYXNpbHkgZG9uZS4KPiAKPiAtIFNv
bHV0aW9uCj4gCj4gVGhpcyBwYXRjaCBpcyBhIGRyaXZlciB0aGF0IGV4cG9zZXMgYSBtb25vdG9u
aWMgaW5jcmVtZW50YWwgVmlydHVhbAo+IE1hY2hpbmUgR2VuZXJhdGlvbiB1MzIgY291bnRlciB2
aWEgYSBjaGFyLWRldiBGUyBpbnRlcmZhY2UgdGhhdAo+IHByb3ZpZGVzIHN5bmMgYW5kIGFzeW5j
IFZtR2VuIGNvdW50ZXIgdXBkYXRlcyBub3RpZmljYXRpb25zLiBJdCBhbHNvCj4gcHJvdmlkZXMg
Vm1HZW4gY291bnRlciByZXRyaWV2YWwgYW5kIGNvbmZpcm1hdGlvbiBtZWNoYW5pc21zLgo+IAo+
IFRoZSBodyBwcm92aWRlZCBVVUlEIGlzIG5vdCBleHBvc2VkIHRvIHVzZXJzcGFjZSwgaXQgaXMg
aW50ZXJuYWxseQo+IHVzZWQgYnkgdGhlIGRyaXZlciB0byBrZWVwIGFjY291bnRpbmcgZm9yIHRo
ZSBleHBvc2VkIFZtR2VuIGNvdW50ZXIuCj4gVGhlIGNvdW50ZXIgc3RhcnRzIGZyb20gemVybyB3
aGVuIHRoZSBkcml2ZXIgaXMgaW5pdGlhbGl6ZWQgYW5kCj4gbW9ub3RvbmljYWxseSBpbmNyZW1l
bnRzIGV2ZXJ5IHRpbWUgdGhlIGh3IFVVSUQgY2hhbmdlcyAodGhlIFZNCj4gZ2VuZXJhdGlvbiBj
aGFuZ2VzKS4KPiAKPiBPbiBlYWNoIGh3IFVVSUQgY2hhbmdlLCB0aGUgbmV3IGh5cGVydmlzb3It
cHJvdmlkZWQgVVVJRCBpcyBhbHNvIGZlZAo+IHRvIHRoZSBrZXJuZWwgUk5HLgo+IAo+IFRoaXMg
cGF0Y2ggYnVpbGRzIG9uIHRvcCBvZiBPciBJZGdhciA8b3JpZGdhckBnbWFpbC5jb20+J3MgcHJv
cG9zYWwKPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC8zLzEvNDk4Cj4gCj4gLSBGdXR1cmUg
aW1wcm92ZW1lbnRzCj4gCj4gSWRlYWxseSB3ZSB3b3VsZCB3YW50IHRoZSBkcml2ZXIgdG8gcmVn
aXN0ZXIgaXRzZWxmIGJhc2VkIG9uIGRldmljZXMnCj4gX0NJRCBhbmQgbm90IF9ISUQsIGJ1dCB1
bmZvcnR1bmF0ZWx5IEkgY291bGRuJ3QgZmluZCBhIHdheSB0byBkbyB0aGF0Lgo+IFRoZSBwcm9i
bGVtIGlzIHRoYXQgQUNQSSBkZXZpY2UgbWF0Y2hpbmcgaXMgZG9uZSBieQo+ICdfX2FjcGlfbWF0
Y2hfZGV2aWNlKCknIHdoaWNoIGV4Y2x1c2l2ZWx5IGxvb2tzIGF0Cj4gJ2FjcGlfaGFyZHdhcmVf
aWQgKmh3aWQnLgo+IAo+IFRoZXJlIGlzIGEgcGF0aCBmb3IgcGxhdGZvcm0gZGV2aWNlcyB0byBt
YXRjaCBvbiBfQ0lEIHdoZW4gX0hJRCBpcwo+ICdQUlAwMDAxJyAtIGJ1dCB0aGlzIGlzIG5vdCB0
aGUgY2FzZSBmb3IgdGhlIFFlbXUgdm1nZW5pZCBkZXZpY2UuCj4gCj4gR3VpZGFuY2UgYW5kIGhl
bHAgaGVyZSB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLgoKVGhhdCBvbmUgaXMgcHJldHR5
IGltcG9ydGFudCBJTUhPLiBIb3cgYWJvdXQgdGhlIGZvbGxvd2luZyAocHJvYmFibHkgCnByZXR0
eSBtYW5nbGVkKSBwYXRjaD8gVGhhdCBzZWVtcyB0byB3b3JrIGZvciBtZS4gVGhlIEFDUEkgY2hh
bmdlIHdvdWxkIApvYnZpb3VzbHkgbmVlZCB0byBiZSBpdHMgb3duIHN0YW5kIGFsb25lIGNoYW5n
ZSBhbmQgbmVlZHMgcHJvcGVyIAphc3Nlc3NtZW50IHdoZXRoZXIgaXQgY291bGQgcG9zc2libHkg
YnJlYWsgYW55IGV4aXN0aW5nIHN5c3RlbXMuCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2J1
cy5jIGIvZHJpdmVycy9hY3BpL2J1cy5jCmluZGV4IDE2ODJmOGI0NTRhMi4uNDUyNDQzZDc5ZDg3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYnVzLmMKKysrIGIvZHJpdmVycy9hY3BpL2J1cy5j
CkBAIC03NDgsNyArNzQ4LDcgQEAgc3RhdGljIGJvb2wgX19hY3BpX21hdGNoX2RldmljZShzdHJ1
Y3QgYWNwaV9kZXZpY2UgCipkZXZpY2UsCiAgCQkvKiBGaXJzdCwgY2hlY2sgdGhlIEFDUEkvUE5Q
IElEcyBwcm92aWRlZCBieSB0aGUgY2FsbGVyLiAqLwogIAkJaWYgKGFjcGlfaWRzKSB7CiAgCQkJ
Zm9yIChpZCA9IGFjcGlfaWRzOyBpZC0+aWRbMF0gfHwgaWQtPmNsczsgaWQrKykgewotCQkJCWlm
IChpZC0+aWRbMF0gJiYgIXN0cmNtcCgoY2hhciAqKWlkLT5pZCwgaHdpZC0+aWQpKQorCQkJCWlm
IChpZC0+aWRbMF0gJiYgIXN0cm5jbXAoKGNoYXIgKilpZC0+aWQsIGh3aWQtPmlkLCBBQ1BJX0lE
X0xFTiAtIDEpKQogIAkJCQkJZ290byBvdXRfYWNwaV9tYXRjaDsKICAJCQkJaWYgKGlkLT5jbHMg
JiYgX19hY3BpX21hdGNoX2RldmljZV9jbHMoaWQsIGh3aWQpKQogIAkJCQkJZ290byBvdXRfYWNw
aV9tYXRjaDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC92bWdlbmlkLmMgYi9kcml2ZXJzL3Zp
cnQvdm1nZW5pZC5jCmluZGV4IDc1YTc4N2RhOGFhZC4uMGJmYTQyMmNmMDk0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3ZpcnQvdm1nZW5pZC5jCisrKyBiL2RyaXZlcnMvdmlydC92bWdlbmlkLmMKQEAg
LTM1Niw3ICszNTYsOCBAQCBzdGF0aWMgdm9pZCB2bWdlbmlkX2FjcGlfbm90aWZ5KHN0cnVjdCBh
Y3BpX2RldmljZSAKKmRldmljZSwgdTMyIGV2ZW50KQogIH0KCiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhY3BpX2RldmljZV9pZCB2bWdlbmlkX2lkc1tdID0gewotCXsiUUVNVVZHSUQiLCAwfSwKKwkv
KiBUaGlzIHJlYWxseSBpcyBWTV9HZW5fQ291bnRlciwgYnV0IHdlIGNhbiBvbmx5IG1hdGNoIDgg
Y2hhcmFjdGVycyAqLworCXsiVk1fR0VOX0MiLCAwfSwKICAJeyIiLCAwfSwKICB9OwoKCj4gCj4g
LSB2MSAtPiB2MjoKPgoKUGxlYXNlIHB1dCB0aGUgY2hhbmdlIGxvZyBiZWxvdyB5b3VyIFNpZ25l
ZC1vZmYtYnkgbGluZSBhbmQgc2VwYXJhdGUgaXQgCndpdGggYSAiLS0tIiBsaW5lLiBUaGF0IHdh
eSwgZ2l0IGFtIHdpbGwgaWdub3JlIHRoZSBjaGFuZ2UgbG9nIG9uIGFwcGx5LgoKCj4gICAgLSBl
eHBvc2UgdG8gdXNlcnNwYWNlIGEgbW9ub3RvbmljYWxseSBpbmNyZWFzaW5nIHUzMiBWbSBHZW4g
Q291bnRlcgo+ICAgICAgaW5zdGVhZCBvZiB0aGUgaHcgVm1HZW4gVVVJRAo+ICAgIC0gc2luY2Ug
dGhlIGh3L2h5cGVydmlzb3ItcHJvdmlkZWQgMTI4LWJpdCBVVUlEIGlzIG5vdCBwdWJsaWMKPiAg
ICAgIGFueW1vcmUsIGFkZCBpdCB0byB0aGUga2VybmVsIFJORyBhcyBkZXZpY2UgcmFuZG9tbmVz
cwo+ICAgIC0gaW5zZXJ0IGRyaXZlciBwYWdlIGNvbnRhaW5pbmcgVm0gR2VuIENvdW50ZXIgaW4g
dGhlIHVzZXIgdm1hIGluCj4gICAgICB0aGUgZHJpdmVyJ3MgbW1hcCBoYW5kbGVyIGluc3RlYWQg
b2YgdXNpbmcgYSBmYXVsdCBoYW5kbGVyCj4gICAgLSB0dXJuIGRyaXZlciBpbnRvIGEgbWlzYyBk
ZXZpY2UgZHJpdmVyIHRvIGF1dG8tY3JlYXRlIC9kZXYvdm1nZW5pZAo+ICAgIC0gY2hhbmdlIGlv
Y3RsIGFyZyB0byBhdm9pZCBsZWFraW5nIGtlcm5lbCBzdHJ1Y3RzIHRvIHVzZXJzcGFjZQo+ICAg
IC0gdXBkYXRlIGRvY3VtZW50YXRpb24KPiAgICAtIHZhcmlvdXMgbml0cyAobGljZW5zZSwgdW5u
ZWNlc3NhcnkgY2FzdGluZywgS2NvbmZpZywgb3RoZXJzKQo+ICAgIC0gcmViYXNlIG9uIHRvcCBv
ZiBsaW51cyBsYXRlc3QKPiAKPiBTaWduZWQtb2ZmLWJ5OiBBZHJpYW4gQ2F0YW5naXUgPGFjYXRh
bkBhbWF6b24uY29tPgo+IC0tLQo+ICAgRG9jdW1lbnRhdGlvbi92aXJ0L3ZtZ2VuaWQucnN0IHwg
MjI4ICsrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy92aXJ0L0tjb25maWcgICAg
ICAgICAgIHwgIDE3ICsrCj4gICBkcml2ZXJzL3ZpcnQvTWFrZWZpbGUgICAgICAgICAgfCAgIDEg
Kwo+ICAgZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYyAgICAgICAgIHwgMzkwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBpbmNsdWRlL3VhcGkvbGludXgvdm1nZW5p
ZC5oICAgfCAgMTMgKysKPiAgIDUgZmlsZXMgY2hhbmdlZCwgNjQ5IGluc2VydGlvbnMoKykKPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3ZpcnQvdm1nZW5pZC5yc3QKPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZpcnQvdm1nZW5pZC5jCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS91YXBpL2xpbnV4L3ZtZ2VuaWQuaAo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL3ZpcnQvdm1nZW5pZC5yc3QgYi9Eb2N1bWVudGF0aW9uL3ZpcnQvdm1nZW5pZC5y
c3QKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAuLjYwM2U4YTUKPiAtLS0g
L2Rldi9udWxsCj4gKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0L3ZtZ2VuaWQucnN0Cj4gQEAgLTAs
MCArMSwyMjggQEAKPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArCj4g
Kz09PT09PT09PT09PQo+ICtWTUdFTklECj4gKz09PT09PT09PT09PQo+ICsKPiArVGhlIFZNIEdl
bmVyYXRpb24gSUQgaXMgYSBmZWF0dXJlIGRlZmluZWQgYnkgTWljcm9zb2Z0IChwYXBlcjoKPiAr
aHR0cDovL2dvLm1pY3Jvc29mdC5jb20vZndsaW5rLz9MaW5rSWQ9MjYwNzA5KSBhbmQgc3VwcG9y
dGVkIGJ5Cj4gK211bHRpcGxlIGh5cGVydmlzb3IgdmVuZG9ycy4KPiArCj4gK1RoZSBmZWF0dXJl
IGlzIHJlcXVpcmVkIGluIHZpcnR1YWxpemVkIGVudmlyb25tZW50cyBieSBhcHBzIHRoYXQgd29y
awo+ICt3aXRoIGxvY2FsIGNvcGllcy9jYWNoZXMgb2Ygd29ybGQtdW5pcXVlIGRhdGEgc3VjaCBh
cyByYW5kb20gdmFsdWVzLAo+ICt1dWlkcywgbW9ub3RvbmljYWxseSBpbmNyZWFzaW5nIGNvdW50
ZXJzLCBldGMuCj4gK1N1Y2ggYXBwcyBjYW4gYmUgbmVnYXRpdmVseSBhZmZlY3RlZCBieSBWTSBz
bmFwc2hvdHRpbmcgd2hlbiB0aGUgVk0KPiAraXMgZWl0aGVyIGNsb25lZCBvciByZXR1cm5lZCB0
byBhbiBlYXJsaWVyIHBvaW50IGluIHRpbWUuCj4gKwo+ICtUaGUgVk0gR2VuZXJhdGlvbiBJRCBp
cyBhIHNpbXBsZSBjb25jZXB0IG1lYW50IHRvIGFsbGV2aWF0ZSB0aGUgaXNzdWUKPiArYnkgcHJv
dmlkaW5nIGEgdW5pcXVlIElEIHRoYXQgY2hhbmdlcyBlYWNoIHRpbWUgdGhlIFZNIGlzIHJlc3Rv
cmVkCj4gK2Zyb20gYSBzbmFwc2hvdC4gVGhlIGh3IHByb3ZpZGVkIFVVSUQgdmFsdWUgY2FuIGJl
IHVzZWQgdG8KPiArZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIFZNcyBvciBkaWZmZXJlbnQgZ2VuZXJh
dGlvbnMgb2YgdGhlIHNhbWUgVk0uCj4gKwo+ICtUaGUgVk0gR2VuZXJhdGlvbiBJRCBpcyBleHBv
c2VkIHRocm91Z2ggYW4gQUNQSSBkZXZpY2UgYnkgbXVsdGlwbGUKPiAraHlwZXJ2aXNvciB2ZW5k
b3JzLiBUaGUgZHJpdmVyIGZvciBpdCBsaXZlcyBhdAo+ICtgYGRyaXZlcnMvdmlydC92bWdlbmlk
LmNgYAo+ICsKPiArVGhlIGRyaXZlciBleHBvc2VzIGEgbW9ub3RvbmljIGluY3JlbWVudGFsIFZp
cnR1YWwgTWFjaGluZSBHZW5lcmF0aW9uCj4gK3UzMiBjb3VudGVyIHZpYSBhIGNoYXItZGV2IEZT
IGludGVyZmFjZSB0aGF0IHByb3ZpZGVzIHN5bmMgYW5kIGFzeW5jCj4gK1ZtR2VuIGNvdW50ZXIg
dXBkYXRlcyBub3RpZmljYXRpb25zLiBJdCBhbHNvIHByb3ZpZGVzIFZtR2VuIGNvdW50ZXIKPiAr
cmV0cmlldmFsIGFuZCBjb25maXJtYXRpb24gbWVjaGFuaXNtcy4KPiArCj4gK1RoZSBodyBwcm92
aWRlZCBVVUlEIGlzIG5vdCBleHBvc2VkIHRvIHVzZXJzcGFjZSwgaXQgaXMgaW50ZXJuYWxseQo+
ICt1c2VkIGJ5IHRoZSBkcml2ZXIgdG8ga2VlcCBhY2NvdW50aW5nIGZvciB0aGUgZXhwb3NlZCBW
bUdlbiBjb3VudGVyLgo+ICtUaGUgY291bnRlciBzdGFydHMgZnJvbSB6ZXJvIHdoZW4gdGhlIGRy
aXZlciBpcyBpbml0aWFsaXplZCBhbmQKPiArbW9ub3RvbmljYWxseSBpbmNyZW1lbnRzIGV2ZXJ5
IHRpbWUgdGhlIGh3IFVVSUQgY2hhbmdlcyAodGhlIFZNCj4gK2dlbmVyYXRpb24gY2hhbmdlcyku
Cj4gKwo+ICtPbiBlYWNoIGh3IFVVSUQgY2hhbmdlLCB0aGUgbmV3IFVVSUQgaXMgYWxzbyBmZWQg
dG8gdGhlIGtlcm5lbCBSTkcuCj4gKwo+ICtEcml2ZXIgaW50ZXJmYWNlOgo+ICsKPiArYGBvcGVu
KClgYDoKPiArICBXaGVuIHRoZSBkZXZpY2UgaXMgb3BlbmVkLCBhIGNvcHkgb2YgdGhlIGN1cnJl
bnQgVm0tR2VuLUlkIChjb3VudGVyKQo+ICsgIGlzIGFzc29jaWF0ZWQgd2l0aCB0aGUgb3BlbiBm
aWxlIGRlc2NyaXB0b3IuIFRoZSBkcml2ZXIgbm93IHRyYWNrcwo+ICsgIHRoaXMgZmlsZSBhcyBh
biBpbmRlcGVuZGVudCAqd2F0Y2hlciouIFRoZSBkcml2ZXIgdHJhY2tzIGhvdyBtYW55Cj4gKyAg
d2F0Y2hlcnMgYXJlIGF3YXJlIG9mIHRoZSBsYXRlc3QgVm0tR2VuLUlkIGNvdW50ZXIgYW5kIGhv
dyBtYW55IG9mCj4gKyAgdGhlbSBhcmUgKm91dGRhdGVkKjsgb3V0ZGF0ZWQgYmVpbmcgdGhvc2Ug
dGhhdCBoYXZlIGxpdmVkIHRocm91Z2gKPiArICBhIFZtLUdlbi1JZCBjaGFuZ2UgYnV0IG5vdCB5
ZXQgY29uZmlybWVkIHRoZSBuZXcgZ2VuZXJhdGlvbiBjb3VudGVyLgo+ICsKPiArYGByZWFkKClg
YDoKPiArICBSZWFkIGlzIG1lYW50IHRvIHByb3ZpZGUgdGhlICpuZXcqIFZNIGdlbmVyYXRpb24g
Y291bnRlciB3aGVuIGEKPiArICBnZW5lcmF0aW9uIGNoYW5nZSB0YWtlcyBwbGFjZS4gVGhlIHJl
YWQgb3BlcmF0aW9uIGJsb2NrcyB1bnRpbCB0aGUKPiArICBhc3NvY2lhdGVkIGNvdW50ZXIgaXMg
bm8gbG9uZ2VyIHVwIHRvIGRhdGUgLSB1bnRpbCBIVyB2bSBnZW4gaWQKPiArICBjaGFuZ2VzIC0g
YXQgd2hpY2ggcG9pbnQgdGhlIG5ldyBjb3VudGVyIGlzIHByb3ZpZGVkL3JldHVybmVkLgo+ICsg
IE5vbmJsb2NraW5nIGBgcmVhZCgpYGAgdXNlcyBgYEVBR0FJTmBgIHRvIHNpZ25hbCB0aGF0IHRo
ZXJlIGlzIG5vCj4gKyAgKm5ldyogY291bnRlciB2YWx1ZSBhdmFpbGFibGUuIFRoZSBnZW5lcmF0
aW9uIGNvdW50ZXIgaXMgY29uc2lkZXJlZAo+ICsgICpuZXcqIGZvciBlYWNoIG9wZW4gZmlsZSBk
ZXNjcmlwdG9yIHRoYXQgaGFzbid0IGNvbmZpcm1lZCB0aGUgbmV3Cj4gKyAgdmFsdWUsIGZvbGxv
d2luZyBhIGdlbmVyYXRpb24gY2hhbmdlLiBUaGVyZWZvcmUsIG9uY2UgYSBnZW5lcmF0aW9uCj4g
KyAgY2hhbmdlIHRha2VzIHBsYWNlLCBhbGwgYGByZWFkKClgYCBjYWxscyB3aWxsIGltbWVkaWF0
ZWx5IHJldHVybiB0aGUKPiArICBuZXcgZ2VuZXJhdGlvbiBjb3VudGVyIGFuZCB3aWxsIGNvbnRp
bnVlIHRvIGRvIHNvIHVudGlsIHRoZQo+ICsgIG5ldyB2YWx1ZSBpcyBjb25maXJtZWQgYmFjayB0
byB0aGUgZHJpdmVyIHRocm91Z2ggYGB3cml0ZSgpYGAuCj4gKyAgUGFydGlhbCByZWFkcyBhcmUg
bm90IGFsbG93ZWQgLSByZWFkIGJ1ZmZlciBuZWVkcyB0byBiZSBhdCBsZWFzdAo+ICsgIGBgc2l6
ZW9mKHVuc2lnbmVkKWBgIGluIHNpemUuCj4gKwo+ICtgYHdyaXRlKClgYDoKPiArICBXcml0ZSBp
cyB1c2VkIHRvIGNvbmZpcm0gdGhlIHVwLXRvLWRhdGUgVm0gR2VuIGNvdW50ZXIgYmFjayB0byB0
aGUKPiArICBkcml2ZXIuCj4gKyAgRm9sbG93aW5nIGEgVk0gZ2VuZXJhdGlvbiBjaGFuZ2UsIGFs
bCBleGlzdGluZyB3YXRjaGVycyBhcmUgbWFya2VkCj4gKyAgYXMgKm91dGRhdGVkKi4gRWFjaCBm
aWxlIGRlc2NyaXB0b3Igd2lsbCBtYWludGFpbiB0aGUgKm91dGRhdGVkKgo+ICsgIHN0YXR1cyB1
bnRpbCBhIGBgd3JpdGUoKWBgIGNvbmZpcm1zIHRoZSB1cC10by1kYXRlIGNvdW50ZXIgYmFjayB0
bwo+ICsgIHRoZSBkcml2ZXIuCj4gKyAgUGFydGlhbCB3cml0ZXMgYXJlIG5vdCBhbGxvd2VkIC0g
d3JpdGUgYnVmZmVyIHNob3VsZCBiZSBleGFjdGx5Cj4gKyAgYGBzaXplb2YodW5zaWduZWQpYGAg
aW4gc2l6ZS4KPiArCj4gK2BgcG9sbCgpYGA6Cj4gKyAgUG9sbCBpcyBpbXBsZW1lbnRlZCB0byBh
bGxvdyBwb2xsaW5nIGZvciBnZW5lcmF0aW9uIGNvdW50ZXIgdXBkYXRlcy4KPiArICBTdWNoIHVw
ZGF0ZXMgcmVzdWx0IGluIGBgRVBPTExJTmBgIHBvbGxpbmcgc3RhdHVzIHVudGlsIHRoZSBuZXcK
PiArICB1cC10by1kYXRlIGNvdW50ZXIgaXMgY29uZmlybWVkIGJhY2sgdG8gdGhlIGRyaXZlciB0
aHJvdWdoIGEKPiArICBgYHdyaXRlKClgYC4KPiArCj4gK2BgaW9jdGwoKWBgOgo+ICsgIFRoZSBk
cml2ZXIgYWxzbyBhZGRzIHN1cHBvcnQgZm9yIHRyYWNraW5nIGNvdW50IG9mIG9wZW4gZmlsZQo+
ICsgIGRlc2NyaXB0b3JzIHRoYXQgaGF2ZW4ndCBhY2tub3dsZWRnZWQgYSBnZW5lcmF0aW9uIGNv
dW50ZXIgdXBkYXRlLgo+ICsgIFRoaXMgaXMgZXhwb3NlZCB0aHJvdWdoIHR3byBJT0NUTHM6Cj4g
Kwo+ICsgIC0gVk1HRU5JRF9HRVRfT1VUREFURURfV0FUQ0hFUlM6IGltbWVkaWF0ZWx5IHJldHVy
bnMgdGhlIG51bWJlciBvZgo+ICsgICAgKm91dGRhdGVkKiB3YXRjaGVycyAtIG51bWJlciBvZiBm
aWxlIGRlc2NyaXB0b3JzIHRoYXQgd2VyZSBvcGVuCj4gKyAgICBkdXJpbmcgYSBWTSBnZW5lcmF0
aW9uIGNoYW5nZSwgYW5kIHdoaWNoIGhhdmUgbm90IHlldCBjb25maXJtZWQgdGhlCj4gKyAgICBu
ZXcgZ2VuZXJhdGlvbiBjb3VudGVyLgo+ICsgIC0gVk1HRU5JRF9XQUlUX1dBVENIRVJTOiBibG9j
a3MgdW50aWwgdGhlcmUgYXJlIG5vIG1vcmUgKm91dGRhdGVkKgo+ICsgICAgd2F0Y2hlcnMsIG9y
IGlmIGEgYGB0aW1lb3V0YGAgYXJndW1lbnQgaXMgcHJvdmlkZWQsIHVudGlsIHRoZQo+ICsgICAg
dGltZW91dCBleHBpcmVzLgo+ICsKPiArYGBtbWFwKClgYDoKPiArICBUaGUgZHJpdmVyIHN1cHBv
cnRzIGBgUFJPVF9SRUFELCBNQVBfU0hBUkVEYGAgbW1hcHMgb2YgYSBzaW5nbGUgcGFnZQo+ICsg
IGluIHNpemUuIFRoZSBmaXJzdCA0IGJ5dGVzIG9mIHRoZSBtYXBwZWQgcGFnZSB3aWxsIGNvbnRh
aW4gYW4KPiArICB1cC10by1kYXRlIGNvcHkgb2YgdGhlIFZNIGdlbmVyYXRpb24gY291bnRlci4K
PiArICBUaGUgbWFwcGVkIG1lbW9yeSBjYW4gYmUgdXNlZCBhcyBhIGxvdy1sYXRlbmN5IGdlbmVy
YXRpb24gY291bnRlcgo+ICsgIHByb2JlIG1lY2hhbmlzbSBpbiBjcml0aWNhbCBzZWN0aW9ucyAt
IHNlZSBleGFtcGxlcy4KPiArCj4gK2BgY2xvc2UoKWBgOgo+ICsgIFJlbW92ZXMgdGhlIGZpbGUg
ZGVzY3JpcHRvciBhcyBhIFZtIGdlbmVyYXRpb24gY291bnRlciB3YXRjaGVyLgo+ICsKPiArRXhh
bXBsZSBhcHBsaWNhdGlvbiB3b3JrZmxvd3MKPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiArCj4gKzEpIFdhdGNoZG9nIHRocmVhZCBzaW1wbGlmaWVkIGV4YW1wbGU6Ogo+ICsKPiAr
CXZvaWQgd2F0Y2hkb2dfdGhyZWFkX2hhbmRsZXIoaW50ICp0aHJlYWRfYWN0aXZlKQo+ICsJewo+
ICsJCXVuc2lnbmVkIGdlbmlkOwo+ICsJCWludCBmZCA9IG9wZW4oIi9kZXYvdm1nZW5pZCIsIE9f
UkRXUiB8IE9fQ0xPRVhFQywgU19JUlVTUiB8IFNfSVdVU1IpOwo+ICsKPiArCQlkbyB7Cj4gKwkJ
CS8vIHJlYWQgbmV3IGdlbiBJRCAtIGJsb2NrcyB1bnRpbCBWTSBnZW5lcmF0aW9uIGNoYW5nZXMK
PiArCQkJcmVhZChmZCwgJmdlbmlkLCBzaXplb2YoZ2VuaWQpKTsKPiArCj4gKwkJCS8vIGJlY2F1
c2Ugb2YgVk0gZ2VuZXJhdGlvbiBjaGFuZ2UsIHdlIG5lZWQgdG8gcmVidWlsZCB3b3JsZAo+ICsJ
CQlyZXNlZWRfYXBwX2VudigpOwo+ICsKPiArCQkJLy8gY29uZmlybSB3ZSdyZSBkb25lIGhhbmRs
aW5nIGdlbiBJRCB1cGRhdGUKPiArCQkJd3JpdGUoZmQsICZnZW5pZCwgc2l6ZW9mKGdlbmlkKSk7
Cj4gKwkJfSB3aGlsZSAoYXRvbWljX3JlYWQodGhyZWFkX2FjdGl2ZSkpOwo+ICsKPiArCQljbG9z
ZShmZCk7Cj4gKwl9Cj4gKwo+ICsyKSBBU1lOQyBzaW1wbGlmaWVkIGV4YW1wbGU6Ogo+ICsKPiAr
CXZvaWQgaGFuZGxlX2lvX29uX3ZtZ2VuZmQoaW50IHZtZ2VuZmQpCj4gKwl7Cj4gKwkJdW5zaWdu
ZWQgZ2VuaWQ7Cj4gKwo+ICsJCS8vIGJlY2F1c2Ugb2YgVk0gZ2VuZXJhdGlvbiBjaGFuZ2UsIHdl
IG5lZWQgdG8gcmVidWlsZCB3b3JsZAo+ICsJCXJlc2VlZF9hcHBfZW52KCk7Cj4gKwo+ICsJCS8v
IHJlYWQgbmV3IGdlbiBJRCAtIHdlIG5lZWQgaXQgdG8gY29uZmlybSB3ZSd2ZSBoYW5kbGVkIHVw
ZGF0ZQo+ICsJCXJlYWQoZmQsICZnZW5pZCwgc2l6ZW9mKGdlbmlkKSk7CgpUaGlzIGlzIHJhY3kg
aW4gY2FzZSB0d28gY29uc2VjdXRpdmUgc25hcHNob3RzIGhhcHBlbi4gVGhlIHJlYWQgbmVlZHMg
dG8gCmdvIGJlZm9yZSB0aGUgcmVzZWVkLgoKPiArCj4gKwkJLy8gY29uZmlybSB3ZSdyZSBkb25l
IGhhbmRsaW5nIHRoZSBnZW4gSUQgdXBkYXRlCj4gKwkJd3JpdGUoZmQsICZnZW5pZCwgc2l6ZW9m
KGdlbmlkKSk7Cj4gKwl9Cj4gKwo+ICsJaW50IG1haW4oKSB7Cj4gKwkJaW50IGVwZmQsIHZtZ2Vu
ZmQ7Cj4gKwkJc3RydWN0IGVwb2xsX2V2ZW50IGV2Owo+ICsKPiArCQllcGZkID0gZXBvbGxfY3Jl
YXRlKEVQT0xMX1FVRVVFX0xFTik7Cj4gKwo+ICsJCXZtZ2VuZmQgPSBvcGVuKCIvZGV2L3ZtZ2Vu
aWQiLAo+ICsJCSAgICAgICAgICAgICAgIE9fUkRXUiB8IE9fQ0xPRVhFQyB8IE9fTk9OQkxPQ0ss
Cj4gKwkJICAgICAgICAgICAgICAgU19JUlVTUiB8IFNfSVdVU1IpOwo+ICsKPiArCQkvLyByZWdp
c3RlciB2bWdlbmlkIGZvciBwb2xsaW5nCj4gKwkJZXYuZXZlbnRzID0gRVBPTExJTjsKPiArCQll
di5kYXRhLmZkID0gdm1nZW5mZDsKPiArCQllcG9sbF9jdGwoZXBmZCwgRVBPTExfQ1RMX0FERCwg
dm1nZW5mZCwgJmV2KTsKPiArCj4gKwkJLy8gcmVnaXN0ZXIgb3RoZXIgcGFydHMgb2YgeW91ciBh
cHAgZm9yIHBvbGxpbmcKPiArCQkvLyAuLi4KPiArCj4gKwkJd2hpbGUgKDEpIHsKPiArCQkJLy8g
d2FpdCBmb3Igc29tZXRoaW5nIHRvIGRvLi4uCj4gKwkJCWludCBuZmRzID0gZXBvbGxfd2FpdChl
cGZkLCBldmVudHMsCj4gKwkJCQlNQVhfRVBPTExfRVZFTlRTX1BFUl9SVU4sCj4gKwkJCQlFUE9M
TF9SVU5fVElNRU9VVCk7Cj4gKwkJCWlmIChuZmRzIDwgMCkgZGllKCJFcnJvciBpbiBlcG9sbF93
YWl0ISIpOwo+ICsKPiArCQkJLy8gZm9yIGVhY2ggcmVhZHkgZmQKPiArCQkJZm9yKGludCBpID0g
MDsgaSA8IG5mZHM7IGkrKykgewo+ICsJCQkJaW50IGZkID0gZXZlbnRzW2ldLmRhdGEuZmQ7Cj4g
Kwo+ICsJCQkJaWYgKGZkID09IHZtZ2VuZmQpCj4gKwkJCQkJaGFuZGxlX2lvX29uX3ZtZ2VuZmQo
dm1nZW5mZCk7Cj4gKwkJCQllbHNlCj4gKwkJCQkJaGFuZGxlX3NvbWVfb3RoZXJfcGFydF9vZl90
aGVfYXBwKGZkKTsKPiArCQkJfQo+ICsJCX0KPiArCj4gKwkJcmV0dXJuIDA7Cj4gKwl9Cj4gKwo+
ICszKSBNYXBwZWQgbWVtb3J5IHBvbGxpbmcgc2ltcGxpZmllZCBleGFtcGxlOjoKPiArCj4gKwkv
Kgo+ICsJICogYXBwL2xpYnJhcnkgZnVuY3Rpb24gdGhhdCBwcm92aWRlcyBjYWNoZWQgc2VjcmV0
cwo+ICsJICovCj4gKwljaGFyICogc2FmZV9jYWNoZWRfc2VjcmV0KGFwcF9kYXRhX3QgKmFwcCkK
PiArCXsKPiArCQljaGFyICpzZWNyZXQ7Cj4gKwkJdm9sYXRpbGUgdW5zaWduZWQgKmNvbnN0IGdl
bmlkX3B0ciA9IGdldF92bWdlbmlkX21hcHBpbmcoYXBwKTsKPiArCWFnYWluOgo+ICsJCXNlY3Jl
dCA9IF9fY2FjaGVkX3NlY3JldChhcHApOwo+ICsKPiArCQlpZiAodW5saWtlbHkoKmdlbmlkX3B0
ciAhPSBhcHAtPmNhY2hlZF9nZW5pZCkpIHsKPiArCQkJLy8gcmVidWlsZCB3b3JsZCB0aGVuIGNv
bmZpcm0gdGhlIGdlbmlkIHVwZGF0ZSAodGhydSB3cml0ZSkKPiArCQkJcmVidWlsZF9jYWNoZXMo
YXBwKTsKPiArCj4gKwkJCWFwcC0+Y2FjaGVkX2dlbmlkID0gKmdlbmlkX3B0cjsKClRoaXMgaXMg
cmFjeSBhZ2Fpbi4gWW91IG5lZWQgdG8gcmVhZCB0aGUgZ2VuaWQgYmVmb3JlIHJlYnVpbGQgYW5k
IHNldCBpdCAKaGVyZS4KCj4gKwkJCWFja192bWdlbmlkX3VwZGF0ZShhcHApOwo+ICsKPiArCQkJ
Z290byBhZ2FpbjsKPiArCQl9Cj4gKwo+ICsJCXJldHVybiBzZWNyZXQ7Cj4gKwl9Cj4gKwo+ICs0
KSBPcmNoZXN0cmF0b3Igc2ltcGxpZmllZCBleGFtcGxlOjoKPiArCj4gKwkvKgo+ICsJICogb3Jj
aGVzdHJhdG9yIC0gbWFuYWdlcyBtdWx0aXBsZSBhcHBzIGFuZCBsaWJyYXJpZXMgdXNlZCBieSBh
IHNlcnZpY2UKPiArCSAqIGFuZCB0cmllcyB0byBtYWtlIHN1cmUgYWxsIHNlbnNpdGl2ZSBjb21w
b25lbnRzIGdyYWNlZnVsbHkgaGFuZGxlCj4gKwkgKiBWTSBnZW5lcmF0aW9uIGNoYW5nZXMuCj4g
KwkgKiBGb2xsb3dpbmcgZnVuY3Rpb24gaXMgY2FsbGVkIG9uIGRldGVjdGlvbiBvZiBhIFZNIGdl
bmVyYXRpb24gY2hhbmdlLgo+ICsJICovCj4gKwlpbnQgaGFuZGxlX3ZtZ2VuX3VwZGF0ZShpbnQg
dm1nZW5fZmQsIHVuc2lnbmVkIG5ld19nZW5faWQpCj4gKwl7Cj4gKwkJLy8gcGF1c2UgdW50aWwg
YWxsIGNvbXBvbmVudHMgaGF2ZSBoYW5kbGVkIGV2ZW50Cj4gKwkJcGF1c2Vfc2VydmljZSgpOwo+
ICsKPiArCQkvLyBjb25maXJtICp0aGlzKiB3YXRjaGVyIGFzIHVwLXRvLWRhdGUKPiArCQl3cml0
ZSh2bWdlbl9mZCwgJm5ld19nZW5faWQsIHNpemVvZih1bnNpZ25lZCkpOwo+ICsKPiArCQkvLyB3
YWl0IGZvciBhbGwgKm90aGVycyogZm9yIGF0IG1vc3QgNSBzZWNvbmRzLgo+ICsJCWlvY3RsKHZt
Z2VuX2ZkLCBWTUdFTklEX1dBSVRfV0FUQ0hFUlMsIDUwMDApOwo+ICsKPiArCQkvLyBhbGwgYXBw
cyBvbiB0aGUgc3lzdGVtIGhhdmUgcmVidWlsdCB3b3JsZHMKPiArCQlyZXN1bWVfc2VydmljZSgp
Owo+ICsJfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvS2NvbmZpZyBiL2RyaXZlcnMvdmly
dC9LY29uZmlnCj4gaW5kZXggODBjNWY5YzEuLjVkNWYzN2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92aXJ0L0tjb25maWcKPiArKysgYi9kcml2ZXJzL3ZpcnQvS2NvbmZpZwo+IEBAIC0xMyw2ICsx
MywyMyBAQCBtZW51Y29uZmlnIFZJUlRfRFJJVkVSUwo+ICAgCj4gICBpZiBWSVJUX0RSSVZFUlMK
PiAgIAo+ICtjb25maWcgVk1HRU5JRAo+ICsJdHJpc3RhdGUgIlZpcnR1YWwgTWFjaGluZSBHZW5l
cmF0aW9uIElEIGRyaXZlciIKPiArCWRlcGVuZHMgb24gQUNQSQo+ICsJZGVmYXVsdCBOCj4gKwlo
ZWxwCj4gKwkgIFRoaXMgaXMgYSBWaXJ0dWFsIE1hY2hpbmUgR2VuZXJhdGlvbiBJRCBkcml2ZXIg
d2hpY2ggcHJvdmlkZXMKPiArCSAgYSB2aXJ0dWFsIG1hY2hpbmUgZ2VuZXJhdGlvbiBjb3VudGVy
LiBUaGUgZHJpdmVyIGV4cG9zZXMgRlMgb3BzCj4gKwkgIG9uIC9kZXYvdm1nZW5pZCB0aHJvdWdo
IHdoaWNoIGl0IGNhbiBwcm92aWRlIGluZm9ybWF0aW9uIGFuZAo+ICsJICBub3RpZmljYXRpb25z
IG9uIFZNIGdlbmVyYXRpb24gY2hhbmdlcyB0aGF0IGhhcHBlbiBvbiBzbmFwc2hvdHMKPiArCSAg
b3IgY2xvbmluZy4KPiArCSAgVGhpcyBlbmFibGVzIGFwcGxpY2F0aW9ucyBhbmQgbGlicmFyaWVz
IHRoYXQgc3RvcmUgb3IgY2FjaGUKPiArCSAgc2Vuc2l0aXZlIGluZm9ybWF0aW9uLCB0byBrbm93
IHRoYXQgdGhleSBuZWVkIHRvIHJlZ2VuZXJhdGUgaXQKPiArCSAgYWZ0ZXIgcHJvY2VzcyBtZW1v
cnkgaGFzIGJlZW4gZXhwb3NlZCB0byBwb3RlbnRpYWwgY29weWluZy4KPiArCj4gKwkgIFRvIGNv
bXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQo+ICsJICBt
b2R1bGUgd2lsbCBiZSBjYWxsZWQgdm1nZW5pZC4KPiArCj4gICBjb25maWcgRlNMX0hWX01BTkFH
RVIKPiAgIAl0cmlzdGF0ZSAiRnJlZXNjYWxlIGh5cGVydmlzb3IgbWFuYWdlbWVudCBkcml2ZXIi
Cj4gICAJZGVwZW5kcyBvbiBGU0xfU09DCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9NYWtl
ZmlsZSBiL2RyaXZlcnMvdmlydC9NYWtlZmlsZQo+IGluZGV4IGYyODQyNWMuLjg4OWJlMDEgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0L01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy92aXJ0L01h
a2VmaWxlCj4gQEAgLTQsNiArNCw3IEBACj4gICAjCj4gICAKPiAgIG9iai0kKENPTkZJR19GU0xf
SFZfTUFOQUdFUikJKz0gZnNsX2h5cGVydmlzb3Iubwo+ICtvYmotJChDT05GSUdfVk1HRU5JRCkJ
CSs9IHZtZ2VuaWQubwo+ICAgb2JqLXkJCQkJKz0gdmJveGd1ZXN0Lwo+ICAgCj4gICBvYmotJChD
T05GSUdfTklUUk9fRU5DTEFWRVMpCSs9IG5pdHJvX2VuY2xhdmVzLwo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnQvdm1nZW5pZC5jIGIvZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYwo+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMC4uNzVhNzg3ZAo+IC0tLSAvZGV2L251bGwKPiAr
KysgYi9kcml2ZXJzL3ZpcnQvdm1nZW5pZC5jCj4gQEAgLTAsMCArMSwzOTAgQEAKPiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArLyoKPiArICogVmlydHVhbCBNYWNoaW5l
IEdlbmVyYXRpb24gSUQgZHJpdmVyCj4gKyAqCj4gKyAqIENvcHlyaWdodCAoQykgMjAxOCBSZWQg
SGF0IEluYy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KPiArICoKPiArICogQ29weXJpZ2h0IChDKSAy
MDIwIEFtYXpvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KPiArICoKPiArICoJQXV0aG9yczoKPiAr
ICoJICBBZHJpYW4gQ2F0YW5naXUgPGFjYXRhbkBhbWF6b24uY29tPgo+ICsgKgkgIE9yIElkZ2Fy
IDxvcmlkZ2FyQGdtYWlsLmNvbT4KPiArICoJICBHYWwgSGFtbWVyIDxnaGFtbWVyQHJlZGhhdC5j
b20+Cj4gKyAqCj4gKyAqLwo+ICsjaW5jbHVkZSA8bGludXgvYWNwaS5oPgo+ICsjaW5jbHVkZSA8
bGludXgva2VybmVsLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9taXNjZGV2aWNlLmg+Cj4gKyNpbmNs
dWRlIDxsaW51eC9tbS5oPgo+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gKyNpbmNsdWRl
IDxsaW51eC9wb2xsLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4KPiArI2luY2x1ZGUg
PGxpbnV4L3V1aWQuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3ZtZ2VuaWQuaD4KPiArCj4gKyNkZWZp
bmUgREVWX05BTUUgInZtZ2VuaWQiCj4gK0FDUElfTU9EVUxFX05BTUUoREVWX05BTUUpOwo+ICsK
PiArc3RydWN0IGRldl9kYXRhIHsKPiArCXN0cnVjdCBtaXNjZGV2aWNlIG1pc2NfZGV2Owo+ICsJ
dW5zaWduZWQgbG9uZyAgICAgbWFwX2J1ZjsKPiArCXdhaXRfcXVldWVfaGVhZF90IHJlYWRfd2Fp
dDsKPiArCXVuc2lnbmVkIGludCAgICAgIGdlbmVyYXRpb25fY291bnRlcjsKPiArCj4gKwl2b2lk
ICAgICAgICAgICAgICAqdXVpZF9pb21hcDsKPiArCXV1aWRfdCAgICAgICAgICAgIHV1aWQ7Cj4g
Kwo+ICsJYXRvbWljX3QgICAgICAgICAgd2F0Y2hlcnM7Cj4gKwlhdG9taWNfdCAgICAgICAgICBv
dXRkYXRlZF93YXRjaGVyczsKPiArCXdhaXRfcXVldWVfaGVhZF90IG91dGRhdGVkX3dhaXQ7Cj4g
K307Cj4gKwo+ICtzdHJ1Y3QgZmlsZV9kYXRhIHsKPiArCXN0cnVjdCBkZXZfZGF0YSAqZGV2X2Rh
dGE7Cj4gKwl1bnNpZ25lZCBpbnQgICAgYWNrZWRfZ2VuX2NvdW50ZXI7Cj4gK307Cj4gKwo+ICtz
dGF0aWMgdm9pZCB2bWdlbmlkX3B1dF9vdXRkYXRlZF93YXRjaGVycyhzdHJ1Y3QgZGV2X2RhdGEg
KnByaXYpCj4gK3sKPiArCWlmIChhdG9taWNfZGVjX2FuZF90ZXN0KCZwcml2LT5vdXRkYXRlZF93
YXRjaGVycykpCj4gKwkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwcml2LT5vdXRkYXRlZF93YWl0
KTsKPiArfQo+ICsKPiArc3RhdGljIGludCB2bWdlbmlkX29wZW4oc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IGZpbGUgKmZpbGUpCj4gK3sKPiArCXN0cnVjdCBkZXZfZGF0YSAqcHJpdiA9Cj4g
KwkJY29udGFpbmVyX29mKGZpbGUtPnByaXZhdGVfZGF0YSwgc3RydWN0IGRldl9kYXRhLCBtaXNj
X2Rldik7Cj4gKwlzdHJ1Y3QgZmlsZV9kYXRhICpmaWxlX2RhdGEgPQo+ICsJCWt6YWxsb2Moc2l6
ZW9mKHN0cnVjdCBmaWxlX2RhdGEpLCBHRlBfS0VSTkVMKTsKPiArCj4gKwlpZiAoIWZpbGVfZGF0
YSkKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gKwlmaWxlX2RhdGEtPmFja2VkX2dlbl9jb3Vu
dGVyID0gcHJpdi0+Z2VuZXJhdGlvbl9jb3VudGVyOwo+ICsJZmlsZV9kYXRhLT5kZXZfZGF0YSA9
IHByaXY7Cj4gKwo+ICsJZmlsZS0+cHJpdmF0ZV9kYXRhID0gZmlsZV9kYXRhOwo+ICsJYXRvbWlj
X2luYygmcHJpdi0+d2F0Y2hlcnMpOwo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgaW50IHZtZ2VuaWRfY2xvc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZp
bGUpCj4gK3sKPiArCXN0cnVjdCBmaWxlX2RhdGEgKmZpbGVfZGF0YSA9IGZpbGUtPnByaXZhdGVf
ZGF0YTsKPiArCXN0cnVjdCBkZXZfZGF0YSAqcHJpdiA9IGZpbGVfZGF0YS0+ZGV2X2RhdGE7Cj4g
Kwo+ICsJaWYgKGZpbGVfZGF0YS0+YWNrZWRfZ2VuX2NvdW50ZXIgIT0gcHJpdi0+Z2VuZXJhdGlv
bl9jb3VudGVyKQo+ICsJCXZtZ2VuaWRfcHV0X291dGRhdGVkX3dhdGNoZXJzKHByaXYpOwoKSXMg
dGhpcyByYWN5PyBDb3VsZCB0aGVyZSBiZSBhIHNuYXBzaG90IG5vdGlmaWNhdGlvbiBjb21pbmcg
YmV0d2VlbiB0aGUgCmJyYW5jaCBhbmQgdGhlIHB1dD8KCj4gKwlhdG9taWNfZGVjKCZwcml2LT53
YXRjaGVycyk7Cj4gKwlrZnJlZShmaWxlX2RhdGEpOwo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4g
Kwo+ICtzdGF0aWMgc3NpemVfdAo+ICt2bWdlbmlkX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNo
YXIgX191c2VyICp1YnVmLCBzaXplX3QgbmJ5dGVzLCBsb2ZmX3QgKnBwb3MpCj4gK3sKPiArCXN0
cnVjdCBmaWxlX2RhdGEgKmZpbGVfZGF0YSA9IGZpbGUtPnByaXZhdGVfZGF0YTsKPiArCXN0cnVj
dCBkZXZfZGF0YSAqcHJpdiA9IGZpbGVfZGF0YS0+ZGV2X2RhdGE7Cj4gKwlzc2l6ZV90IHJldDsK
PiArCj4gKwlpZiAobmJ5dGVzID09IDApCj4gKwkJcmV0dXJuIDA7Cj4gKwkvKiBkaXNhbGxvdyBw
YXJ0aWFsIHJlYWRzICovCj4gKwlpZiAobmJ5dGVzIDwgc2l6ZW9mKHByaXYtPmdlbmVyYXRpb25f
Y291bnRlcikpCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsJaWYgKGZpbGVfZGF0YS0+YWNr
ZWRfZ2VuX2NvdW50ZXIgPT0gcHJpdi0+Z2VuZXJhdGlvbl9jb3VudGVyKSB7Cj4gKwkJaWYgKGZp
bGUtPmZfZmxhZ3MgJiBPX05PTkJMT0NLKQo+ICsJCQlyZXR1cm4gLUVBR0FJTjsKPiArCQlyZXQg
PSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoCj4gKwkJCXByaXYtPnJlYWRfd2FpdCwKPiArCQkJ
ZmlsZV9kYXRhLT5hY2tlZF9nZW5fY291bnRlciAhPSBwcml2LT5nZW5lcmF0aW9uX2NvdW50ZXIK
PiArCQkpOwo+ICsJCWlmIChyZXQpCj4gKwkJCXJldHVybiByZXQ7Cj4gKwl9Cj4gKwo+ICsJbmJ5
dGVzID0gc2l6ZW9mKHByaXYtPmdlbmVyYXRpb25fY291bnRlcik7Cj4gKwlyZXQgPSBjb3B5X3Rv
X3VzZXIodWJ1ZiwgJnByaXYtPmdlbmVyYXRpb25fY291bnRlciwgbmJ5dGVzKTsKPiArCWlmIChy
ZXQpCj4gKwkJcmV0dXJuIC1FRkFVTFQ7Cj4gKwo+ICsJcmV0dXJuIG5ieXRlczsKPiArfQo+ICsK
PiArc3RhdGljIHNzaXplX3Qgdm1nZW5pZF93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3Qg
Y2hhciBfX3VzZXIgKnVidWYsCj4gKwkJCQlzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykKPiAr
ewo+ICsJc3RydWN0IGZpbGVfZGF0YSAqZmlsZV9kYXRhID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwo+
ICsJc3RydWN0IGRldl9kYXRhICpwcml2ID0gZmlsZV9kYXRhLT5kZXZfZGF0YTsKPiArCXVuc2ln
bmVkIGludCBhY2tlZF9nZW5fY291bnQ7Cj4gKwo+ICsJLyogZGlzYWxsb3cgcGFydGlhbCB3cml0
ZXMgKi8KPiArCWlmIChjb3VudCAhPSBzaXplb2YoYWNrZWRfZ2VuX2NvdW50KSkKPiArCQlyZXR1
cm4gLUVJTlZBTDsKPiArCWlmIChjb3B5X2Zyb21fdXNlcigmYWNrZWRfZ2VuX2NvdW50LCB1YnVm
LCBjb3VudCkpCj4gKwkJcmV0dXJuIC1FRkFVTFQ7Cj4gKwkvKiB3cm9uZyBnZW4tY291bnRlciBh
Y2tub3dsZWRnZWQgKi8KPiArCWlmIChhY2tlZF9nZW5fY291bnQgIT0gcHJpdi0+Z2VuZXJhdGlv
bl9jb3VudGVyKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCWlmIChmaWxlX2RhdGEtPmFj
a2VkX2dlbl9jb3VudGVyICE9IHByaXYtPmdlbmVyYXRpb25fY291bnRlcikgewo+ICsJCS8qIHVw
ZGF0ZSBsb2NhbCB2aWV3IG9mIFVVSUQgKi8KPiArCQlmaWxlX2RhdGEtPmFja2VkX2dlbl9jb3Vu
dGVyID0gYWNrZWRfZ2VuX2NvdW50Owo+ICsJCXZtZ2VuaWRfcHV0X291dGRhdGVkX3dhdGNoZXJz
KHByaXYpOwoKU2FtZSBxdWVzdGlvbiBoZXJlOiBXaGF0IGlmIHRoZXJlIGlzIGEgbm90aWZpY2F0
aW9uIGJldHdlZW4gdGhlIGJyYW5jaCAKYW5kIHRoZSBwdXQ/Cgo+ICsJfQo+ICsKPiArCXJldHVy
biAoc3NpemVfdCljb3VudDsKPiArfQo+ICsKPiArc3RhdGljIF9fcG9sbF90Cj4gK3ZtZ2VuaWRf
cG9sbChzdHJ1Y3QgZmlsZSAqZmlsZSwgcG9sbF90YWJsZSAqd2FpdCkKPiArewo+ICsJX19wb2xs
X3QgbWFzayA9IDA7Cj4gKwlzdHJ1Y3QgZmlsZV9kYXRhICpmaWxlX2RhdGEgPSBmaWxlLT5wcml2
YXRlX2RhdGE7Cj4gKwlzdHJ1Y3QgZGV2X2RhdGEgKnByaXYgPSBmaWxlX2RhdGEtPmRldl9kYXRh
Owo+ICsKPiArCWlmIChmaWxlX2RhdGEtPmFja2VkX2dlbl9jb3VudGVyICE9IHByaXYtPmdlbmVy
YXRpb25fY291bnRlcikKPiArCQlyZXR1cm4gRVBPTExJTiB8IEVQT0xMUkROT1JNOwo+ICsKPiAr
CXBvbGxfd2FpdChmaWxlLCAmcHJpdi0+cmVhZF93YWl0LCB3YWl0KTsKPiArCj4gKwlpZiAoZmls
ZV9kYXRhLT5hY2tlZF9nZW5fY291bnRlciAhPSBwcml2LT5nZW5lcmF0aW9uX2NvdW50ZXIpCj4g
KwkJbWFzayA9IEVQT0xMSU4gfCBFUE9MTFJETk9STTsKPiArCj4gKwlyZXR1cm4gbWFzazsKPiAr
fQo+ICsKPiArc3RhdGljIGxvbmcgdm1nZW5pZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwKPiAr
CQl1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZykKPiArewo+ICsJc3RydWN0IGZp
bGVfZGF0YSAqZmlsZV9kYXRhID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwo+ICsJc3RydWN0IGRldl9k
YXRhICpwcml2ID0gZmlsZV9kYXRhLT5kZXZfZGF0YTsKPiArCXVuc2lnbmVkIGxvbmcgdGltZW91
dF9ucyA9IGFyZyAqIE5TRUNfUEVSX01TRUM7Cj4gKwlrdGltZV90IHVudGlsID0ga3RpbWVfc2V0
KDAsIHRpbWVvdXRfbnMpOwo+ICsJaW50IHJldDsKPiArCj4gKwlzd2l0Y2ggKGNtZCkgewo+ICsJ
Y2FzZSBWTUdFTklEX0dFVF9PVVREQVRFRF9XQVRDSEVSUzoKPiArCQlyZXQgPSBhdG9taWNfcmVh
ZCgmcHJpdi0+b3V0ZGF0ZWRfd2F0Y2hlcnMpOwo+ICsJCWJyZWFrOwo+ICsJY2FzZSBWTUdFTklE
X1dBSVRfV0FUQ0hFUlM6Cj4gKwkJcmV0ID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2hydGlt
ZW91dCgKPiArCQkJcHJpdi0+b3V0ZGF0ZWRfd2FpdCwKPiArCQkJIWF0b21pY19yZWFkKCZwcml2
LT5vdXRkYXRlZF93YXRjaGVycyksCj4gKwkJCXVudGlsCj4gKwkJKTsKPiArCQlicmVhazsKPiAr
CWRlZmF1bHQ6Cj4gKwkJcmV0ID0gLUVJTlZBTDsKPiArCQlicmVhazsKPiArCX0KPiArCXJldHVy
biByZXQ7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgdm1nZW5pZF9tbWFwKHN0cnVjdCBmaWxlICpm
aWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKPiArewo+ICsJc3RydWN0IGZpbGVfZGF0
YSAqZmlsZV9kYXRhID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwo+ICsJc3RydWN0IGRldl9kYXRhICpw
cml2ID0gZmlsZV9kYXRhLT5kZXZfZGF0YTsKPiArCj4gKwlpZiAodm1hLT52bV9wZ29mZiAhPSAw
IHx8IHZtYV9wYWdlcyh2bWEpID4gMSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlpZiAo
KHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkgIT0gMCkKPiArCQlyZXR1cm4gLUVQRVJNOwo+ICsK
PiArCXZtYS0+dm1fZmxhZ3MgfD0gVk1fRE9OVEVYUEFORCB8IFZNX0RPTlREVU1QOwo+ICsJdm1h
LT52bV9mbGFncyAmPSB+Vk1fTUFZV1JJVEU7Cj4gKwl2bWEtPnZtX3ByaXZhdGVfZGF0YSA9IGZp
bGVfZGF0YTsKPiArCj4gKwlyZXR1cm4gdm1faW5zZXJ0X3BhZ2Uodm1hLCB2bWEtPnZtX3N0YXJ0
LAo+ICsJCQkJCQkgIHZpcnRfdG9fcGFnZShwcml2LT5tYXBfYnVmKSk7CgpJcyB0aGlzIHdlaXJk
IHdoaXRlIHNwYWNlIGludHJvZHVjZWQgYnkgbXkgbWFpbCBjbGllbnQgb3IgeW91ciBwYXRjaD8g
OikKCgpBbGV4CgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVz
ZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hs
YWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3
IDg3OQoKCg==

