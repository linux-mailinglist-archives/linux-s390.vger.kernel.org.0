Return-Path: <linux-s390+bounces-2024-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8E85E0B9
	for <lists+linux-s390@lfdr.de>; Wed, 21 Feb 2024 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108E11C219CC
	for <lists+linux-s390@lfdr.de>; Wed, 21 Feb 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A27FBCE;
	Wed, 21 Feb 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b="iJ458szd"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail03.softline.ru (mail03.softline.ru [185.31.132.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085877BB01;
	Wed, 21 Feb 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.31.132.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528532; cv=none; b=GnmKMLtGjNCuLqZt3dqtvYpR8d/1KJtVG1M7UVfQenljH/pNpxEhL5x7CRnG3SiKihdmSZ9niM+a1ZpX7RfaQI8Vq7Bp1UoKHfUkyAOgY8o+QGD/SxP7P976k5OiIzClrNbICv4LZHZDmb2slVWdPpSA66IUSPrdFiPKSmk3rz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528532; c=relaxed/simple;
	bh=U6LTfCt0Y1XPyuR94BitQJbK5CnBSk/B7Nw6HVJH6Fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IfFySxVgwAoYcvtib+br9reenCN7mrgFZytxKw17ZbKOfYkMu44+HmXrgbJVkIyze8KOm4nb9FyEDcqHgEiD/k8ThEoBhZkPxnUGnfoGOCsjLV4A11pgsUDnuRG6gA0cwl0RZ1e2ow4NZEuSK+D3toZRIcOhlWbjZmRcjwaKWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com; spf=pass smtp.mailfrom=softline.com; dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b=iJ458szd; arc=none smtp.client-ip=185.31.132.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softline.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=softline.com;
	s=relay; t=1708527753;
	bh=U6LTfCt0Y1XPyuR94BitQJbK5CnBSk/B7Nw6HVJH6Fg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iJ458szdbaR+GPmssPMBH5c6BF5E5yqynzPs5+eCZ8CSMon/y7GdMI6Wu+/Qwh1gm
	 wLavdwgy5yUdMd+HZHzeAJXbGk3bBMeqGVZaQL33LBg0+fOfwQShGmWdqoAb/jM5VS
	 8TtVloFxvYDOJMuoElqdmB2FXpn5ZzHXjvHqcgUH64nIVwLlDRCDqGftrXpCrx/Cuu
	 8OnObgmVubqIDuwGRxs/vwCCkI4R+aLmolRf9L2Y27LVxmZMqHnNbsBHS/1SHojV1A
	 zaLpQ1ZjY3p1nhX1DSa56ImQDnsyQOVmeP0Pq3skGYYhCAnEZt5msOFrnMO2p4vVGp
	 CE75AzeJDnIQg==
X-AuditID: 0a02150b-b13ff700000026cc-8e-65d61088c3be
From: "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
To: "dmantipov@yandex.ru" <dmantipov@yandex.ru>, "guwen@linux.alibaba.com"
	<guwen@linux.alibaba.com>, "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jaka@linux.ibm.com"
	<jaka@linux.ibm.com>
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
Thread-Topic: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
Thread-Index: AQHaZNb+eL3YMOb6v02FhrfSeOr3xw==
Date: Wed, 21 Feb 2024 15:02:32 +0000
Message-ID: <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
	 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
In-Reply-To: <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DFFCC98B65EA848ABDAAC7BA160D4F7@softline.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDIxOjA5ICswODAwLCBXZW4gR3Ugd3JvdGU6DQoNCj4gMS4g
b24gPSAxOyBpb2N0bChzb2NrLCBGSU9BU1lOQywgJm9uKSwgYSBmYXN5bmMgZW50cnkgaXMgYWRk
ZWQgdG8NCj4gICAgIHNtYy0+c2suc2tfc29ja2V0LT53cS5mYXN5bmNfbGlzdDsNCj4gDQo+IDIu
IFRoZW4gZmFsbGJhY2sgaGFwcGVuZCwgYW5kIHN3YXBwZWQgdGhlIHNvY2tldDoNCj4gICAgIHNt
Yy0+Y2xjc29jay0+ZmlsZSA9IHNtYy0+c2suc2tfc29ja2V0LT5maWxlOw0KPiAgICAgc21jLT5j
bGNzb2NrLT5maWxlLT5wcml2YXRlX2RhdGEgPSBzbWMtPmNsY3NvY2s7DQo+ICAgICBzbWMtPmNs
Y3NvY2stPndxLmZhc3luY19saXN0ID0gc21jLT5zay5za19zb2NrZXQtPndxLmZhc3luY19saXN0
Ow0KPiAgICAgc21jLT5zay5za19zb2NrZXQtPndxLmZhc3luY19saXN0ID0gTlVMTDsNCj4gDQo+
IDMuIG9uID0gMDsgaW9jdGwoc29jaywgRklPQVNZTkMsICZvbiksIHRoZSBmYXN5bmMgZW50cnkg
aXMgcmVtb3ZlZA0KPiAgICAgZnJvbSBzbWMtPmNsY3NvY2stPndxLmZhc3luY19saXN0LA0KPiAo
SXMgdGhlcmUgYSByYWNlIGJldHdlZW4gMiBhbmQgMyA/KQ0KDQoxKSBJSVVDIHllcy4gVGhlIGZv
bGxvd2luZyBzZXF1ZW5jZSBmcm9tIHNtY19zd2l0Y2hfdG9fZmFsbGJhY2soKToNCg0Kc21jLT5j
bGNzb2NrLT5maWxlID0gc21jLT5zay5za19zb2NrZXQtPmZpbGU7DQpzbWMtPmNsY3NvY2stPmZp
bGUtPnByaXZhdGVfZGF0YSA9IHNtYy0+Y2xjc29jazsNCg0KaXMgZXhlY3V0ZWQgd2l0aCBsb2Nr
ZWQgc21jLT5zay5za19zb2NrZXQgYnV0IHVubG9ja2VkIHNtYy0+Y2xjc29jay4NClRoaXMgd2F5
LA0KDQpzdHJ1Y3Qgc29ja2V0ICpzb2NrID0gZmlscC0+cHJpdmF0ZV9kYXRhOw0KDQppbiBzb2Nr
X2Zhc3luYygpIGludHJvZHVjZXMgYW4gdW5kZWZpbmVkIGJlaGF2aW9yIChiZWNhdXNlIGFuDQph
Y3R1YWwgdmFsdWUgb2YgJ3ByaXZhdGVfZGF0YScgaXMgdW5wcmVkaWN0YWJsZSkuIFNvIHRoZXJl
IGFyZQ0KdHdvIHBvc3NpYmxlIHNjZW5hcmlvcy4gV2hlbg0KDQpvbiA9IDE7IGlvY3RsKHNvY2ss
IEZJT0FTWU5DLCAmb24pOw0Kb24gPSAwOyBpb2N0bChzb2NrLCBGSU9BU1lOQywgJm9uKTsNCg0K
YWN0dWFsbHkgbW9kaWZpZXMgZmFzeW5jIGxpc3Qgb2YgdGhlIHNhbWUgc29ja2V0LCB0aGlzIHdv
cmtzIGFzDQpleHBlY3RlZC4gSWYga2VybmVsIHNvY2tldHMgYmVoaW5kICdzb2NrJyBnZXRzIHN3
YXBwZWQgYmV0d2Vlbg0KY2FsbHMgdG8gaW9jdGwoKSwgZmFzeW5jIGxpc3Qgb2YgdGhlIGZpcnN0
IHNvY2tldCBoYXMgYW4gZW50cnkNCndoaWNoIGNhbid0IGJlIHJlbW92ZWQgYnkgdGhlIHNlY29u
ZCBpb2N0bCgpLiANCg0KDQo+IDQuIFRoZW4gY2xvc2UgdGhlIGZpbGUsIF9fZnB1dCgpIGNhbGxz
IGZpbGUtPmZfb3AtPmZhc3luYygtMSwgZmlsZSwgMCksDQo+ICAgICB0aGVuIHNvY2tfZmFzeW5j
KCkgY2FsbHMgZmFzeW5jX2hlbHBlcihmZCwgZmlscCwgb24sICZ3cS0+ZmFzeW5jX2xpc3QpDQo+
ICAgICBhbmQgZmFzeW5jX3JlbW92ZV9lbnRyeSgpIHJlbW92ZXMgZW50cmllcyBpbiBzbWMtPmNs
Y3NvY2stPndxLmZhc3luY19saXN0Lg0KPiAgICAgTm93IHNtYy0+Y2xjc29jay0+d3EuZmFzeW5j
X2xpc3QgaXMgZW1wdHkuDQoNCjIpIE5vLiBJbiB0aGUgc2Vjb25kIChiYWQpIHNjZW5hcmlvIGZy
b20gdGhlIGFib3ZlLCBhbiBhdHRlbXB0IHRvIHJlbW92ZQ0KZmFzeW5jIGVudHJ5IGZyb20gc21j
LT5jbGNzb2NrLT53cS5mYXN5bmNfbGlzdCBhbHdheXMgZmFpbHMgYmVjYXVzZQ0KZmFzeW5jIGVu
dHJ5IHdhcyBhY3R1YWxseSBsaW5rZWQgdG8gc21jLT5zay5za19zb2NrZXQtPndxLmZhc3luY19s
aXN0Lg0KDQpOb3RlIHNvY2tfZmFzeW5jKCkgZG9lc24ndCBjaGVjayB0aGUgdmFsdWUgcmV0dXJu
ZWQgZnJvbSBmYXN5bmNfaGVscGVyKCkuDQpIb3cgZHVtYi4NCg0KPiA1LiBfX2ZwdXQoKSBjYWxs
cyBmaWxlLT5mX29wLT5yZWxlYXNlKGlub2RlLCBmaWxlKSwgdGhlbiBzb2NrX2Nsb3NlIGNhbGxz
DQo+ICAgICBfX3NvY2tfcmVsZWFzZSwgdGhlbiBvcHMtPnJlbGVhc2UgY2FsbHMgc21jX3JlbGVh
c2UoKSwgYW5kIF9fc21jX3JlbGVhc2UoKQ0KPiAgICAgY2FsbHMgc21jX3Jlc3RvcmVfZmFsbGJh
Y2tfY2hhbmdlcygpIHRvIHJlc3RvcmUgc29ja2V0Og0KPiAgICAgaWYgKHNtYy0+Y2xjc29jay0+
ZmlsZSkgeyAvKiBub24tYWNjZXB0ZWQgc29ja2V0cyBoYXZlIG5vIGZpbGUgeWV0ICovDQo+ICAg
ICAgICAgIHNtYy0+Y2xjc29jay0+ZmlsZS0+cHJpdmF0ZV9kYXRhID0gc21jLT5zay5za19zb2Nr
ZXQ7DQo+ICAgICAgICAgIHNtYy0+Y2xjc29jay0+ZmlsZSA9IE5VTEw7DQo+ICAgICAgICAgIHNt
Y19mYmFja19yZXN0b3JlX2NhbGxiYWNrcyhzbWMpOw0KPiAgICAgfQ0KDQozKSBZZXMuIEFuZCBp
dCdzIHRvbyBsYXRlIGJlY2F1c2UgX19mcHV0KCkgY2FsbHMgZmlsZS0+Zl9vcC0+ZmFzeW5jKC0x
LCAuLi4sDQowKSBfYmVmb3JlXyBmaWxlLT5mX29wLT5yZWxlYXNlKCkuIFNvIGV2ZW4gaWYgeW91
IGhhdmUgc29ja2V0cyBzd2FwcGVkIGJhY2ssDQpubyBvbmUgd2lsbCB0YWtlIGNhcmUgYWJvdXQg
ZnJlZWluZyBmYXN5bmMgbGlzdC4NCg0KDQo+IDYuIFRoZW4gYmFjayB0byBfX3NvY2tfcmVsZWFz
ZSwgY2hlY2sgaWYgc29jay0+d3EuZmFzeW5jX2xpc3QgKHRoYXQgaXMNCj4gICAgIHNtYy0+c2su
c2tfc29ja2V0LT53cS5mYXN5bmNfbGlzdCkgaXMgZW1wdHkgYW5kIGl0IGlzIGVtcHR5Lg0KDQo0
KSBOby4gSXQncyBub3QgZW1wdHkgYmVjYXVzZSBhbiBhdHRlbXB0IHRvIHJlbW92ZSBmYXN5bmMg
ZW50cnkgaGFzIGZhaWxlZA0KYXQgWzJdIGp1c3QgYmVjYXVzZSBpdCB3YXMgbWFkZSBhZ2FpbnN0
IHRoZSB3cm9uZyBzb2NrZXQuIA0KDQoNCkZvciB5b3VyIGNvbnZlbmllbmNlLCB0aGVyZSBpcyBh
IGh1bWFuLXJlYWRhYmxlIHJlcHJvZHVjZXIgbG9vc2VseSBtb2RlbGVkDQphcm91bmQgdGhlIG9u
ZSBnZW5lcmF0ZWQgYnkgc3l6a2FsbGVyLiBZb3UgY2FuIHRyeSBpdCBvbiBhbnkgc3lzdGVtIHJ1
bm5pbmcNCnJlY2VudGx5IGVub3VnaCBrZXJuZWwgd2l0aCBDT05GSUdfU01DIGVuYWJsZWQgKHJv
b3QgaXMgbm90IHJlcXVpcmVkKSwgYW5kDQpyZWNlaXZpbmcgYSBmZXcgKG9yIG1heSBiZSBhIGxv
dCBvZikgIl9fc29ja19yZWxlYXNlOiBmYXN5bmMgbGlzdCBub3QgZW1wdHkiDQptZXNzYWdlcyBj
bGVhcmx5IGluZGljYXRlcyBhbiBpc3N1ZS4gTk9URTogdGhpcyBzaG91bGRuJ3QgY3Jhc2ggdGhl
IHN5c3RlbQ0KYW5kL29yIG1ha2UgaXQgdW51c2FibGUsIGJ1dCByZW1lbWJlciB0aGF0IGVhY2gg
bWVzc2FnZSBjb21lcyB3aXRoIGEgc21hbGwNCmtlcm5lbCBtZW1vcnkgbGVhay4NCg0KRG1pdHJ5
DQoNCiNpbmNsdWRlIDxzaWduYWwuaD4NCiNpbmNsdWRlIDx1bmlzdGQuaD4NCiNpbmNsdWRlIDxw
dGhyZWFkLmg+DQojaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQojaW5jbHVkZSA8c3lzL3NvY2tldC5o
Pg0KDQppbnQgc29jazsNCg0Kdm9pZCAqDQpsb29wMCAodm9pZCAqYXJnKQ0Kew0KICBzdHJ1Y3Qg
bXNnaGRyIG1zZyA9IHsgMCB9Ow0KDQogIHdoaWxlICgxKQ0KICAgIHsNCiAgICAgIHNvY2sgPSBz
b2NrZXQgKEFGX1NNQywgU09DS19TVFJFQU0sIDApOw0KICAgICAgc2VuZG1zZyAoc29jaywgJm1z
ZywgTVNHX0ZBU1RPUEVOKTsNCiAgICAgIGNsb3NlIChzb2NrKTsNCiAgICB9DQogIHJldHVybiBO
VUxMOw0KfQ0KDQp2b2lkICoNCmxvb3AxICh2b2lkICphcmcpDQp7DQogIGludCBvbjsNCg0KICB3
aGlsZSAoMSkNCiAgICB7DQogICAgICBvbiA9IDE7DQogICAgICBpb2N0bCAoc29jaywgRklPQVNZ
TkMsICZvbik7DQogICAgICBvbiA9IDA7DQogICAgICBpb2N0bCAoc29jaywgRklPQVNZTkMsICZv
bik7DQogICAgfQ0KDQogIHJldHVybiBOVUxMOw0KfQ0KDQppbnQNCm1haW4gKGludCBhcmdjLCBj
aGFyICphcmd2W10pDQp7DQogIHB0aHJlYWRfdCBhLCBiOw0KICBzdHJ1Y3Qgc2lnYWN0aW9uIHNh
ID0geyAwIH07DQoNCiAgc2Euc2FfaGFuZGxlciA9IFNJR19JR047DQogIHNpZ2FjdGlvbiAoU0lH
SU8sICZzYSwgTlVMTCk7DQoNCiAgcHRocmVhZF9jcmVhdGUgKCZhLCBOVUxMLCBsb29wMCwgTlVM
TCk7DQogIHB0aHJlYWRfY3JlYXRlICgmYiwgTlVMTCwgbG9vcDEsIE5VTEwpOw0KDQogIHBhdXNl
ICgpOw0KDQogIHB0aHJlYWRfam9pbiAoYSwgTlVMTCk7DQogIHB0aHJlYWRfam9pbiAoYiwgTlVM
TCk7DQoNCiAgcmV0dXJuIDA7DQp9DQoNCg0K

