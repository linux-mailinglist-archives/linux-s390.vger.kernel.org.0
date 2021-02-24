Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA03238FC
	for <lists+linux-s390@lfdr.de>; Wed, 24 Feb 2021 09:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhBXIty (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 24 Feb 2021 03:49:54 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:61481 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhBXIs7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Feb 2021 03:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614156537; x=1645692537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/R8Bcf3qXRH0sz3GRvHFXvpgzilNaYT4N1/kR6A7D8E=;
  b=c38IPhQVfy9Jv2JFvtptN4FMyurlwQqG1buNxFfYbyN+ywNkXqlTdjrv
   OJsu2GG6HvDEnn8wip4SN7DJE5pr2q7QCHi1mvhQcarA98otWGUTliy33
   YqyZwvwdwlGGfTbtURMBe0+7ypt2Lgwxh18ZZubF8fwo9aHpVxyQeqwFc
   c=;
X-IronPort-AV: E=Sophos;i="5.81,202,1610409600"; 
   d="scan'208";a="91601605"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 24 Feb 2021 08:48:09 +0000
Received: from EX13D08EUB004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id B296FA20A1;
        Wed, 24 Feb 2021 08:47:57 +0000 (UTC)
Received: from uf6ed9c851f4556.ant.amazon.com (10.43.160.157) by
 EX13D08EUB004.ant.amazon.com (10.43.166.158) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Feb 2021 08:47:42 +0000
From:   Adrian Catangiu <acatan@amazon.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <graf@amazon.com>,
        <rdunlap@infradead.org>, <arnd@arndb.de>, <ebiederm@xmission.com>,
        <rppt@kernel.org>, <0x7f454c46@gmail.com>,
        <borntraeger@de.ibm.com>, <Jason@zx2c4.com>, <jannh@google.com>,
        <w@1wt.eu>, <colmmacc@amazon.com>, <luto@kernel.org>,
        <tytso@mit.edu>, <ebiggers@kernel.org>, <dwmw@amazon.co.uk>,
        <bonzini@gnu.org>, <sblbir@amazon.com>, <raduweis@amazon.com>,
        <corbet@lwn.net>, <mst@redhat.com>, <mhocko@kernel.org>,
        <rafael@kernel.org>, <pavel@ucw.cz>, <mpe@ellerman.id.au>,
        <areber@redhat.com>, <ovzxemul@gmail.com>, <avagin@gmail.com>,
        <ptikhomirov@virtuozzo.com>, <gil@azul.com>, <asmehra@redhat.com>,
        <dgunigun@redhat.com>, <vijaysun@ca.ibm.com>, <oridgar@gmail.com>,
        <ghammer@redhat.com>, Adrian Catangiu <acatan@amazon.com>
Subject: [PATCH v7 0/2] System Generation ID driver and VMGENID backend
Date:   Wed, 24 Feb 2021 10:47:30 +0200
Message-ID: <1614156452-17311-1-git-send-email-acatan@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.43.160.157]
X-ClientProxiedBy: EX13D38UWC002.ant.amazon.com (10.43.162.46) To
 EX13D08EUB004.ant.amazon.com (10.43.166.158)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

VGhpcyBmZWF0dXJlIGlzIGFpbWVkIGF0IHZpcnR1YWxpemVkIG9yIGNvbnRhaW5lcml6ZWQgZW52
aXJvbm1lbnRzCndoZXJlIFZNIG9yIGNvbnRhaW5lciBzbmFwc2hvdHRpbmcgZHVwbGljYXRlcyBt
ZW1vcnkgc3RhdGUsIHdoaWNoIGlzIGEKY2hhbGxlbmdlIGZvciBhcHBsaWNhdGlvbnMgdGhhdCB3
YW50IHRvIGdlbmVyYXRlIHVuaXF1ZSBkYXRhIHN1Y2ggYXMKcmVxdWVzdCBJRHMsIFVVSURzLCBh
bmQgY3J5cHRvZ3JhcGhpYyBub25jZXMuCgpUaGUgcGF0Y2ggc2V0IGludHJvZHVjZXMgYSBtZWNo
YW5pc20gdGhhdCBwcm92aWRlcyBhIHVzZXJzcGFjZQppbnRlcmZhY2UgZm9yIGFwcGxpY2F0aW9u
cyBhbmQgbGlicmFyaWVzIHRvIGJlIG1hZGUgYXdhcmUgb2YgdW5pcXVlbmVzcwpicmVha2luZyBl
dmVudHMgc3VjaCBhcyBWTSBvciBjb250YWluZXIgc25hcHNob3R0aW5nLCBhbmQgYWxsb3cgdGhl
bSB0bwpyZWFjdCBhbmQgYWRhcHQgdG8gc3VjaCBldmVudHMuCgpTb2x2aW5nIHRoZSB1bmlxdWVu
ZXNzIHByb2JsZW0gc3Ryb25nbHkgZW5vdWdoIGZvciBjcnlwdG9ncmFwaGljCnB1cnBvc2VzIHJl
cXVpcmVzIGEgbWVjaGFuaXNtIHdoaWNoIGNhbiBkZXRlcm1pbmlzdGljYWxseSByZXNlZWQKdXNl
cnNwYWNlIFBSTkdzIHdpdGggbmV3IGVudHJvcHkgYXQgcmVzdG9yZSB0aW1lLiBUaGlzIG1lY2hh
bmlzbSBtdXN0CmFsc28gc3VwcG9ydCB0aGUgaGlnaC10aHJvdWdocHV0IGFuZCBsb3ctbGF0ZW5j
eSB1c2UtY2FzZXMgdGhhdCBsZWQKcHJvZ3JhbW1lcnMgdG8gcGljayBhIHVzZXJzcGFjZSBQUk5H
IGluIHRoZSBmaXJzdCBwbGFjZTsgYmUgdXNhYmxlIGJ5CmJvdGggYXBwbGljYXRpb24gY29kZSBh
bmQgbGlicmFyaWVzOyBhbGxvdyB0cmFuc3BhcmVudCByZXRyb2ZpdHRpbmcKYmVoaW5kIGV4aXN0
aW5nIHBvcHVsYXIgUFJORyBpbnRlcmZhY2VzIHdpdGhvdXQgY2hhbmdpbmcgYXBwbGljYXRpb24K
Y29kZTsgaXQgbXVzdCBiZSBlZmZpY2llbnQsIGVzcGVjaWFsbHkgb24gc25hcHNob3QgcmVzdG9y
ZTsgYW5kIGJlCnNpbXBsZSBlbm91Z2ggZm9yIHdpZGUgYWRvcHRpb24uCgpUaGUgZmlyc3QgcGF0
Y2ggaW4gdGhlIHNldCBpbXBsZW1lbnRzIGEgZGV2aWNlIGRyaXZlciB3aGljaCBleHBvc2VzIGEK
dGhlIC9kZXYvc3lzZ2VuaWQgY2hhciBkZXZpY2UgdG8gdXNlcnNwYWNlLiBJdHMgYXNzb2NpYXRl
ZCBmaWxlc3lzdGVtCm9wZXJhdGlvbnMgb3BlcmF0aW9ucyBjYW4gYmUgdXNlZCB0byBidWlsZCBh
IHN5c3RlbSBsZXZlbCBzYWZlIHdvcmtmbG93CnRoYXQgZ3Vlc3Qgc29mdHdhcmUgY2FuIGZvbGxv
dyB0byBwcm90ZWN0IGl0c2VsZiBmcm9tIG5lZ2F0aXZlIHN5c3RlbQpzbmFwc2hvdCBlZmZlY3Rz
LgoKVGhlIHNlY29uZCBwYXRjaCBpbiB0aGUgc2V0IGFkZHMgYSBWbUdlbklkIGRyaXZlciB3aGlj
aCBtYWtlcyB1c2Ugb2YKdGhlIEFDUEkgdm1nZW5pZCBkZXZpY2UgdG8gZHJpdmUgU3lzR2VuSWQg
YW5kIHRvIHJlc2VlZCBrZXJuZWwgZW50cm9weQpmb2xsb3dpbmcgVk0gc25hcHNob3RzLgoKKipQ
bGVhc2Ugbm90ZSoqLCBTeXNHZW5JRCBhbG9uZSBkb2VzIG5vdCBndWFyYW50ZWUgY29tcGxldGUg
c25hcHNob3QKc2FmZXR5IHRvIGFwcGxpY2F0aW9ucyB1c2luZyBpdC4gQSBjZXJ0YWluIHdvcmtm
bG93IG5lZWRzIHRvIGJlCmZvbGxvd2VkIGF0IHRoZSBzeXN0ZW0gbGV2ZWwsIGluIG9yZGVyIHRv
IG1ha2UgdGhlIHN5c3RlbQpzbmFwc2hvdC1yZXNpbGllbnQuIFBsZWFzZSBzZWUgdGhlICJTbmFw
c2hvdCBTYWZldHkgUHJlcmVxdWlzaXRlcyIKc2VjdGlvbiBpbiB0aGUgaW5jbHVkZWQgU3lzR2Vu
SUQgZG9jdW1lbnRhdGlvbi4KCi0tLQoKdjYgLT4gdjc6CiAgLSByZW1vdmUgc3lzZ2VuaWQgdWV2
ZW50Cgp2NSAtPiB2NjoKCiAgLSBzeXNnZW5pZDogd2F0Y2hlciB0cmFja2luZyBkaXNhYmxlZCBi
eSBkZWZhdWx0CiAgLSBzeXNnZW5pZDogYWRkIFNZU0dFTklEX1NFVF9XQVRDSEVSX1RSQUNLSU5H
IGlvY3RsIHRvIGFsbG93IGVhY2gKICAgIGZpbGUgZGVzY3JpcHRvciB0byBzZXQgd2hldGhlciB0
aGV5IHNob3VsZCBiZSB0cmFja2VkIGFzIHdhdGNoZXJzCiAgLSByZW5hbWUgU1lTR0VOSURfRk9S
Q0VfR0VOX1VQREFURSAtPiBTWVNHRU5JRF9UUklHR0VSX0dFTl9VUERBVEUKICAtIHJld29yayBh
bGwgZG9jdW1lbnRhdGlvbiB0byBjbGVhcmx5IGNhcHR1cmUgYWxsIHByZXJlcXVpc2l0ZXMgZm9y
CiAgICBhY2hpZXZpbmcgc25hcHNob3Qgc2FmZXR5IHdoZW4gdXNpbmcgdGhlIHByb3ZpZGVkIG1l
Y2hhbmlzbQogIC0gc3lzZ2VuaWQgZG9jdW1lbnRhdGlvbjogcmVwbGFjZSBpbmRpdmlkdWFsIGZp
bGVzeXN0ZW0gb3BlcmF0aW9ucwogICAgZXhhbXBsZXMgd2l0aCBhIGhpZ2hlciBsZXZlbCBleGFt
cGxlIHNob3djYXNpbmcgc3lzdGVtLWxldmVsCiAgICBzbmFwc2hvdC1zYWZlIHdvcmtmbG93Cgp2
NCAtPiB2NToKCiAgLSBzeXNnZW5pZDogZ2VuZXJhdGlvbiBjaGFuZ2VzIGFyZSBhbHNvIGV4cG9y
dGVkIHRocm91Z2ggdWV2ZW50cwogIC0gcmVtb3ZlIFNZU0dFTklEX0dFVF9PVVREQVRFRF9XQVRD
SEVSUyBpb2N0bAogIC0gZG9jdW1lbnQgc3lzZ2VuaWQgaW9jdGwgbWFqb3IvbWlub3IgbnVtYmVy
cwoKdjMgLT4gdjQ6CgogIC0gc3BsaXQgZnVuY3Rpb25hbGl0eSBpbiB0d28gc2VwYXJhdGUga2Vy
bmVsIG1vZHVsZXM6IAogICAgMS4gZHJpdmVycy9taXNjL3N5c2dlbmlkLmMgd2hpY2ggcHJvdmlk
ZXMgdGhlIGdlbmVyaWMgdXNlcnNwYWNlCiAgICAgICBpbnRlcmZhY2UgYW5kIG1lY2hhbmlzbXMK
ICAgIDIuIGRyaXZlcnMvdmlydC92bWdlbmlkLmMgYXMgVk1HRU5JRCBhY3BpIGRldmljZSBkcml2
ZXIgdGhhdCBzZWVkcwogICAgICAga2VybmVsIGVudHJvcHkgYW5kIGFjdHMgYXMgYSBkcml2aW5n
IGJhY2tlbmQgZm9yIHRoZSBnZW5lcmljCiAgICAgICBzeXNnZW5pZAogIC0gcmVuYW1lIC9kZXYv
dm1nZW5pZCAtPiAvZGV2L3N5c2dlbmlkCiAgLSByZW5hbWUgdWFwaSBoZWFkZXIgZmlsZSB2bWdl
bmlkLmggLT4gc3lzZ2VuaWQuaAogIC0gcmVuYW1lIGlvY3RscyBWTUdFTklEXyogLT4gU1lTR0VO
SURfKgogIC0gYWRkIOKAmG1pbl9nZW7igJkgcGFyYW1ldGVyIHRvIFNZU0dFTklEX0ZPUkNFX0dF
Tl9VUERBVEUgaW9jdGwKICAtIGZpeCByYWNlcyBpbiBkb2N1bWVudGF0aW9uIGV4YW1wbGVzCgp2
MiAtPiB2MzoKCiAgLSBzZXBhcmF0ZSB0aGUgY29yZSBkcml2ZXIgbG9naWMgYW5kIGludGVyZmFj
ZSwgZnJvbSB0aGUgQUNQSSBkZXZpY2UuCiAgICBUaGUgQUNQSSB2bWdlbmlkIGRldmljZSBpcyBu
b3cgb25lIHBvc3NpYmxlIGJhY2tlbmQKICAtIGZpeCBpc3N1ZSB3aGVuIHRpbWVvdXQ9MCBpbiBW
TUdFTklEX1dBSVRfV0FUQ0hFUlMKICAtIGFkZCBsb2NraW5nIHRvIGF2b2lkIHJhY2VzIGJldHdl
ZW4gZnMgb3BzIGhhbmRsZXJzIGFuZCBodyBpcnEKICAgIGRyaXZlbiBnZW5lcmF0aW9uIHVwZGF0
ZXMKICAtIGNoYW5nZSBWTUdFTklEX1dBSVRfV0FUQ0hFUlMgaW9jdGwgc28gaWYgdGhlIGN1cnJl
bnQgY2FsbGVyIGlzCiAgICBvdXRkYXRlZCBvciBhIGdlbmVyYXRpb24gY2hhbmdlIGhhcHBlbnMg
d2hpbGUgd2FpdGluZyAodGh1cyBtYWtpbmcKICAgIGN1cnJlbnQgY2FsbGVyIG91dGRhdGVkKSwg
dGhlIGlvY3RsIHJldHVybnMgLUVJTlRSIHRvIHNpZ25hbCB0aGUKICAgIHVzZXIgdG8gaGFuZGxl
IGV2ZW50IGFuZCByZXRyeS4gRml4ZXMgYmxvY2tpbmcgb24gb25lc2VsZgogIC0gYWRkIFZNR0VO
SURfRk9SQ0VfR0VOX1VQREFURSBpb2N0bCBjb25kaXRpb25lZCBieQogICAgQ0FQX0NIRUNLUE9J
TlRfUkVTVE9SRSBjYXBhYmlsaXR5LCB0aHJvdWdoIHdoaWNoIHNvZnR3YXJlIGNhbiBmb3JjZQog
ICAgZ2VuZXJhdGlvbiBidW1wCgp2MSAtPiB2MjoKCiAgLSBleHBvc2UgdG8gdXNlcnNwYWNlIGEg
bW9ub3RvbmljYWxseSBpbmNyZWFzaW5nIHUzMiBWbSBHZW4gQ291bnRlcgogICAgaW5zdGVhZCBv
ZiB0aGUgaHcgVm1HZW4gVVVJRAogIC0gc2luY2UgdGhlIGh3L2h5cGVydmlzb3ItcHJvdmlkZWQg
MTI4LWJpdCBVVUlEIGlzIG5vdCBwdWJsaWMKICAgIGFueW1vcmUsIGFkZCBpdCB0byB0aGUga2Vy
bmVsIFJORyBhcyBkZXZpY2UgcmFuZG9tbmVzcwogIC0gaW5zZXJ0IGRyaXZlciBwYWdlIGNvbnRh
aW5pbmcgVm0gR2VuIENvdW50ZXIgaW4gdGhlIHVzZXIgdm1hIGluCiAgICB0aGUgZHJpdmVyJ3Mg
bW1hcCBoYW5kbGVyIGluc3RlYWQgb2YgdXNpbmcgYSBmYXVsdCBoYW5kbGVyCiAgLSB0dXJuIGRy
aXZlciBpbnRvIGEgbWlzYyBkZXZpY2UgZHJpdmVyIHRvIGF1dG8tY3JlYXRlIC9kZXYvdm1nZW5p
ZAogIC0gY2hhbmdlIGlvY3RsIGFyZyB0byBhdm9pZCBsZWFraW5nIGtlcm5lbCBzdHJ1Y3RzIHRv
IHVzZXJzcGFjZQogIC0gdXBkYXRlIGRvY3VtZW50YXRpb24KCkFkcmlhbiBDYXRhbmdpdSAoMik6
CiAgZHJpdmVycy9taXNjOiBzeXNnZW5pZDogYWRkIHN5c3RlbSBnZW5lcmF0aW9uIGlkIGRyaXZl
cgogIGRyaXZlcnMvdmlydDogdm1nZW5pZDogYWRkIHZtIGdlbmVyYXRpb24gaWQgZHJpdmVyCgog
RG9jdW1lbnRhdGlvbi9taXNjLWRldmljZXMvc3lzZ2VuaWQucnN0ICAgICAgICAgICAgfCAyMjkg
KysrKysrKysrKysrKysrCiBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwt
bnVtYmVyLnJzdCB8ICAgMSArCiBEb2N1bWVudGF0aW9uL3ZpcnQvdm1nZW5pZC5yc3QgICAgICAg
ICAgICAgICAgICAgICB8ICAzNiArKysKIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDE1ICsKIGRyaXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDE1ICsKIGRyaXZlcnMvbWlzYy9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvbWlzYy9zeXNnZW5pZC5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzIyICsrKysrKysrKysrKysrKysrKysrKwog
ZHJpdmVycy92aXJ0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTMg
KwogZHJpdmVycy92aXJ0L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKwogZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxNTMgKysrKysrKysrKwogaW5jbHVkZS91YXBpL2xpbnV4L3N5c2dlbmlkLmggICAgICAgICAg
ICAgICAgICAgICAgfCAgMTggKysKIDExIGZpbGVzIGNoYW5nZWQsIDgwNCBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9taXNjLWRldmljZXMvc3lzZ2VuaWQu
cnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi92aXJ0L3ZtZ2VuaWQucnN0CiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL3N5c2dlbmlkLmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3ZpcnQvdm1nZW5pZC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91
YXBpL2xpbnV4L3N5c2dlbmlkLmgKCi0tIAoyLjcuNAoKCgoKQW1hem9uIERldmVsb3BtZW50IENl
bnRlciAoUm9tYW5pYSkgUy5SLkwuIHJlZ2lzdGVyZWQgb2ZmaWNlOiAyN0EgU2YuIExhemFyIFN0
cmVldCwgVUJDNSwgZmxvb3IgMiwgSWFzaSwgSWFzaSBDb3VudHksIDcwMDA0NSwgUm9tYW5pYS4g
UmVnaXN0ZXJlZCBpbiBSb21hbmlhLiBSZWdpc3RyYXRpb24gbnVtYmVyIEoyMi8yNjIxLzIwMDUu
Cg==

