Return-Path: <linux-s390+bounces-9306-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDBA4D530
	for <lists+linux-s390@lfdr.de>; Tue,  4 Mar 2025 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCAE1736CD
	for <lists+linux-s390@lfdr.de>; Tue,  4 Mar 2025 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94881F872D;
	Tue,  4 Mar 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yDfPkdvV"
X-Original-To: linux-s390@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA313C67C;
	Tue,  4 Mar 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074207; cv=none; b=EDjdItl7EoGzkuSnNhtU12EwKXDX3wL2LnOfuW7mrAMu0+IxjceoSyAiB5dZZtiWjonFOSXWKzScTTL31EAdYzP1j72PNBB5k+AxzLcI2HJOwa56BE9J1NJHDlQw2s8gx0cbGMhekKyfVtx7blUZnKzMXOXwasmcxdl4K4Rn6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074207; c=relaxed/simple;
	bh=q7Y7inN7p9nxDEZdZPPFpPXz6k6mgqWC56UrWP0aGlY=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=KoNQo9vvM/JBbDsv/MgyzheFthWYGyfJ7g/oNdkXRNfCBwhKS+NPM6ILsZFwCexkY54NyHVGfBqHoL4NUUUCmAPIqQ4DfysxqNUvnC2aEEr5QTltlc6oHJAlNLwYQRGGsiJDQES7RiXTwah0cMZafrtgdaDo9h1SiWCzWB+TFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yDfPkdvV; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741073894; bh=q7Y7inN7p9nxDEZdZPPFpPXz6k6mgqWC56UrWP0aGlY=;
	h=From:To:Subject:Date;
	b=yDfPkdvVI+WEfZxNHDjR48RsFOvOG6WgngrwHSHFKzk3zr3eq4UY8wGFRgkwIDTBy
	 yMD0FpcOfkqxlbnztZoF1uokYWE0AEEHRQamP87/8Lijt0cpRqeg9aL2+k63P65Y4E
	 Bi+j3/msPmh+bvxSmFsqtcKf4acBo1oynUP3fyrk=
X-QQ-FEAT: oHWrrGTW1dCni6VLWI7Xi3lwP5c1dnPf
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: OW8WShJdN8S2cMc/fs8JwkE=
X-QQ-XMAILINFO: OTqiK0gT4U+cmgh7WDY0Za7rqIaxfpxORX2UGv52n3gU2ar7Qpb9eMtbJCC1dR
	 XaNmrQ51Qt/0d6QUR9CUZJ1XEueAXQ5JM4n6HQI1J878NGCcrGjDu9P8MraKwA9xN7ic4g4k+PBZB
	 9mIW5oqoCWTINJI9XTTCfs1UJCp1Eov+1/2ySfWLz7SFNjJHMvHbzsFFlZibdJE0qtRDK+GfMa3C+
	 qljfYARMmJC/3fMB+9t6YJCuj6YManWuhJFweN2Uz69afd3ypwmqUUFIL4DvNr8wunxm9RwcD1kSj
	 kkr4686RJD2373KpFz1KuqbNdadvceR7NraymAqYBC6aGf5ejtgoSpJySbmbcZ1fwRFe17Y8kxhZt
	 vhhUkIzosY0DzSdt7Bh+LkASsxRwv07xqODFBTVena2JUVdLsKgorbxWTLAA3k116tf8ExHSD6uWw
	 3lvnDakXzfRpwhW5LrPQO+Ik8qLNpqJlnFL/XwevEYmDcuVqWeIEhuQrgc/w76Rl3iEZTxsLDvKLM
	 cs/6LwEbKhSwBXFE72BBFxA+HrF6kgFIsvB8udPznoq/v2/GFYTRmQf4dMs7OemWahSK1rh+YePB2
	 EBeS2WAoistjvGys92DVeAzh5lZyrSsTrCjNq3y9O5Fv/V5aIXUyuJajPUfKMf0MxxOmXsr9HlyVD
	 Hh4O1rh5NvquLdAFy03omowTjNC1LGD91/UZzaCQUr+i8PIfnr/luFmJVMOnbhxUEvQRtBqdwrmM0
	 e0aC7glvvyxjgofdduCZ3/F1t62VXZmjUnqHt/dzxTAm34B2jDDoeuCamjwqlQ3HaL4nlfeU1ty7X
	 q0SlWIMiiCD9uVBKaBv/v2FcwzNxyHbczziwWFrigKLnSY/isG7RHCFzqpxS7w+FwFZyQvRxGRMjn
	 8NCsDNIKPROftWtqKIT/5q5hHGXOuzSP/sCwS79NBtwvI8FRmNl/odDu3VZbo/T3lGQDH+VkAfvzd
	 +FGGO+4wPis9ZdrOTB
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail284t1741073498t405932
From: "=?ISO-8859-1?B?ZmZoZ2Z2?=" <744439878@qq.com>
To: "=?ISO-8859-1?B?d2Vuamlh?=" <wenjia@linux.ibm.com>, "=?ISO-8859-1?B?amFrYQ==?=" <jaka@linux.ibm.com>, "=?ISO-8859-1?B?YWxpYnVkYQ==?=" <alibuda@linux.alibaba.com>, "=?ISO-8859-1?B?dG9ueWx1?=" <tonylu@linux.alibaba.com>, "=?ISO-8859-1?B?Z3V3ZW4=?=" <guwen@linux.alibaba.com>, "=?ISO-8859-1?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?ISO-8859-1?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?ISO-8859-1?B?a3ViYQ==?=" <kuba@kernel.org>, "=?ISO-8859-1?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?ISO-8859-1?B?aG9ybXM=?=" <horms@kernel.org>, "=?ISO-8859-1?B?bGludXgtcmRtYQ==?=" <linux-rdma@vger.kernel.org>, "=?ISO-8859-1?B?bGludXgtczM5MA==?=" <linux-s390@vger.kernel.org>, "=?ISO-8859-1?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: kernel bug found and suggestions for fixing it
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 4 Mar 2025 02:31:37 -0500
X-Priority: 3
Message-ID: <tencent_CE572E29B79ABD1AB33F1980363ADE182606@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

SGVsbG8sIEkgZm91bmQgYSBidWcgdGl0bGVkICJLQVNBTjogbnVsbC1wdHItZGVyZWYgUmVh
ZCBpbiBzbWNfdGNwX3N5bl9yZWN2X3NvY2siIHdpdGggbW9kaWZpZWQgc3l6a2FsbGVyIGlu
IHRoZSBsYXN0ZWQgdXBzdHJlYW0gcmVsYXRlZCB0byBiY2FjaGVmcyBmaWxlIHN5c3RlbS4K
SWYgeW91IGZpeCB0aGlzIGlzc3VlLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRv
IHRoZSBjb21taXQ6ICBSZXBvcnRlZC1ieTogSmlhbnpob3UgWmhhbyA8eG54YzIyeG54YzIy
QHFxLmNvbT4sICAgIHhpbmd3ZWkgbGVlIDx4cml2ZW5kZWxsN0BnbWFpbC5jb20+LCBaaGl6
aHVvIFRhbmcgPHN0cmZvcmV4Y3R6emNoYW5nZUBmb3htYWlsLmNvbT4KCi0tLS0tLS0tLS0t
LVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpUSVRMRTogS0FTQU46IG51bGwtcHRyLWRlcmVm
IFJlYWQgaW4gc21jX3RjcF9zeW5fcmVjdl9zb2NrCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpCVUc6IEtBU0FO
OiBudWxsLXB0ci1kZXJlZiBpbiBpbnN0cnVtZW50X2F0b21pY19yZWFkIGluY2x1ZGUvbGlu
dXgvaW5zdHJ1bWVudGVkLmg6NjggW2lubGluZV0KQlVHOiBLQVNBTjogbnVsbC1wdHItZGVy
ZWYgaW4gYXRvbWljX3JlYWQgaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWluc3RydW1l
bnRlZC5oOjMyIFtpbmxpbmVdCkJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIHNtY190
Y3Bfc3luX3JlY3Zfc29jaysweGE3LzB4NGMwIG5ldC9zbWMvYWZfc21jLmM6MTMxClJlYWQg
b2Ygc2l6ZSA0IGF0IGFkZHIgMDAwMDAwMDAwMDAwMGEwNCBieSB0YXNrIHN5ei43LjIxLzEy
MzE5CgpDUFU6IDEgVUlEOiAwIFBJRDogMTIzMTkgQ29tbTogc3l6LjcuMjEgTm90IHRhaW50
ZWQgNi4xNC4wLXJjNS1kaXJ0eSAjMgpIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBD
IChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE1LjAtMSAwNC8wMS8yMDE0CkNhbGwg
VHJhY2U6CiA8aXJxPgogX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6OTQgW2lubGlu
ZV0KIGR1bXBfc3RhY2tfbHZsKzB4MTE2LzB4MWIwIGxpYi9kdW1wX3N0YWNrLmM6MTIwCiBr
YXNhbl9yZXBvcnQrMHhiZC8weGYwIG1tL2thc2FuL3JlcG9ydC5jOjYzNAogY2hlY2tfcmVn
aW9uX2lubGluZSBtbS9rYXNhbi9nZW5lcmljLmM6MTgzIFtpbmxpbmVdCiBrYXNhbl9jaGVj
a19yYW5nZSsweGY0LzB4MWEwIG1tL2thc2FuL2dlbmVyaWMuYzoxODkKIGluc3RydW1lbnRf
YXRvbWljX3JlYWQgaW5jbHVkZS9saW51eC9pbnN0cnVtZW50ZWQuaDo2OCBbaW5saW5lXQog
YXRvbWljX3JlYWQgaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWluc3RydW1lbnRlZC5o
OjMyIFtpbmxpbmVdCiBzbWNfdGNwX3N5bl9yZWN2X3NvY2srMHhhNy8weDRjMCBuZXQvc21j
L2FmX3NtYy5jOjEzMQogdGNwX2NoZWNrX3JlcSsweDVlNC8weDFhOTAgbmV0L2lwdjQvdGNw
X21pbmlzb2Nrcy5jOjg2MQogdGNwX3Y0X3JjdisweDE3NTMvMHg0NGUwIG5ldC9pcHY0L3Rj
cF9pcHY0LmM6MjI3NAogaXBfcHJvdG9jb2xfZGVsaXZlcl9yY3UrMHhiYS8weDRjMCBuZXQv
aXB2NC9pcF9pbnB1dC5jOjIwNQogaXBfbG9jYWxfZGVsaXZlcl9maW5pc2grMHgzMjAvMHg1
NzAgbmV0L2lwdjQvaXBfaW5wdXQuYzoyMzMKIE5GX0hPT0sgaW5jbHVkZS9saW51eC9uZXRm
aWx0ZXIuaDozMTQgW2lubGluZV0KIE5GX0hPT0sgaW5jbHVkZS9saW51eC9uZXRmaWx0ZXIu
aDozMDggW2lubGluZV0KIGlwX2xvY2FsX2RlbGl2ZXIrMHgxOWEvMHgyMDAgbmV0L2lwdjQv
aXBfaW5wdXQuYzoyNTQKIGRzdF9pbnB1dCBpbmNsdWRlL25ldC9kc3QuaDo0NjkgW2lubGlu
ZV0KIGlwX3Jjdl9maW5pc2ggbmV0L2lwdjQvaXBfaW5wdXQuYzo0NDcgW2lubGluZV0KIE5G
X0hPT0sgaW5jbHVkZS9saW51eC9uZXRmaWx0ZXIuaDozMTQgW2lubGluZV0KIE5GX0hPT0sg
aW5jbHVkZS9saW51eC9uZXRmaWx0ZXIuaDozMDggW2lubGluZV0KIGlwX3JjdisweDJiZS8w
eDVkMCBuZXQvaXB2NC9pcF9pbnB1dC5jOjU2NwogX19uZXRpZl9yZWNlaXZlX3NrYl9vbmVf
Y29yZSsweDE5Yi8weDFmMCBuZXQvY29yZS9kZXYuYzo1ODkzCiBfX25ldGlmX3JlY2VpdmVf
c2tiKzB4MWQvMHgxNzAgbmV0L2NvcmUvZGV2LmM6NjAwNgogcHJvY2Vzc19iYWNrbG9nKzB4
MzE5LzB4MTQ2MCBuZXQvY29yZS9kZXYuYzo2MzU0CiBfX25hcGlfcG9sbC5jb25zdHByb3Au
MCsweGI2LzB4NTQwIG5ldC9jb3JlL2Rldi5jOjcxODgKIG5hcGlfcG9sbCBuZXQvY29yZS9k
ZXYuYzo3MjU3IFtpbmxpbmVdCiBuZXRfcnhfYWN0aW9uKzB4OWQyLzB4ZTMwIG5ldC9jb3Jl
L2Rldi5jOjczNzkKIGhhbmRsZV9zb2Z0aXJxcysweDFkMS8weDg3MCBrZXJuZWwvc29mdGly
cS5jOjU2MQogZG9fc29mdGlycSBrZXJuZWwvc29mdGlycS5jOjQ2MiBbaW5saW5lXQogZG9f
c29mdGlycSsweGFjLzB4ZTAga2VybmVsL3NvZnRpcnEuYzo0NDkKIDwvaXJxPgogPHRhc2s+
CiBfX2xvY2FsX2JoX2VuYWJsZV9pcCsweDEwMC8weDEyMCBrZXJuZWwvc29mdGlycS5jOjM4
OQogbG9jYWxfYmhfZW5hYmxlIGluY2x1ZGUvbGludXgvYm90dG9tX2hhbGYuaDozMyBbaW5s
aW5lXQogcmN1X3JlYWRfdW5sb2NrX2JoIGluY2x1ZGUvbGludXgvcmN1cGRhdGUuaDo5MTkg
W2lubGluZV0KIF9fZGV2X3F1ZXVlX3htaXQrMHgxYjdhLzB4NDEyMCBuZXQvY29yZS9kZXYu
Yzo0Njc2CiBkZXZfcXVldWVfeG1pdCBpbmNsdWRlL2xpbnV4L25ldGRldmljZS5oOjMzMTMg
W2lubGluZV0KIG5laWdoX2hoX291dHB1dCBpbmNsdWRlL25ldC9uZWlnaGJvdXIuaDo1MjMg
W2lubGluZV0KIG5laWdoX291dHB1dCBpbmNsdWRlL25ldC9uZWlnaGJvdXIuaDo1MzcgW2lu
bGluZV0KIGlwX2ZpbmlzaF9vdXRwdXQyKzB4YzFjLzB4MWYxMCBuZXQvaXB2NC9pcF9vdXRw
dXQuYzoyMzYKIF9faXBfZmluaXNoX291dHB1dCBuZXQvaXB2NC9pcF9vdXRwdXQuYzozMTQg
W2lubGluZV0KIF9faXBfZmluaXNoX291dHB1dCsweDQ0Mi8weDk0MCBuZXQvaXB2NC9pcF9v
dXRwdXQuYzoyOTYKIGlwX2ZpbmlzaF9vdXRwdXQrMHgzNS8weDM4MCBuZXQvaXB2NC9pcF9v
dXRwdXQuYzozMjQKIE5GX0hPT0tfQ09ORCBpbmNsdWRlL2xpbnV4L25ldGZpbHRlci5oOjMw
MyBbaW5saW5lXQogaXBfb3V0cHV0KzB4MTQ2LzB4MmIwIG5ldC9pcHY0L2lwX291dHB1dC5j
OjQzNAogZHN0X291dHB1dCBpbmNsdWRlL25ldC9kc3QuaDo0NTkgW2lubGluZV0KIGlwX2xv
Y2FsX291dCBuZXQvaXB2NC9pcF9vdXRwdXQuYzoxMzAgW2lubGluZV0KIF9faXBfcXVldWVf
eG1pdCsweDE5ZWUvMHgyMWYwIG5ldC9pcHY0L2lwX291dHB1dC5jOjUyOAogX190Y3BfdHJh
bnNtaXRfc2tiKzB4MmE1NS8weDNlNzAgbmV0L2lwdjQvdGNwX291dHB1dC5jOjE0NzEKIF9f
dGNwX3NlbmRfYWNrLnBhcnQuMCsweDM5Yy8weDcyMCBuZXQvaXB2NC90Y3Bfb3V0cHV0LmM6
NDI3NQogX190Y3Bfc2VuZF9hY2sgbmV0L2lwdjQvdGNwX291dHB1dC5jOjQyODEgW2lubGlu
ZV0KIHRjcF9zZW5kX2FjaysweDgxLzB4YTAgbmV0L2lwdjQvdGNwX291dHB1dC5jOjQyODEK
IHRjcF9yY3Zfc3luc2VudF9zdGF0ZV9wcm9jZXNzIG5ldC9pcHY0L3RjcF9pbnB1dC5jOjY2
MDAgW2lubGluZV0KIHRjcF9yY3Zfc3RhdGVfcHJvY2VzcysweDQwZTIvMHg0YzgwIG5ldC9p
cHY0L3RjcF9pbnB1dC5jOjY3OTQKIHRjcF92NF9kb19yY3YrMHgxYTgvMHhhNzAgbmV0L2lw
djQvdGNwX2lwdjQuYzoxOTQxCiBza19iYWNrbG9nX3JjdiBpbmNsdWRlL25ldC9zb2NrLmg6
MTEyMiBbaW5saW5lXQogX19yZWxlYXNlX3NvY2srMHgzMWQvMHg0MDAgbmV0L2NvcmUvc29j
ay5jOjMxMjMKIHJlbGVhc2Vfc29jaysweDVhLzB4MjIwIG5ldC9jb3JlL3NvY2suYzozNjc3
CiB0Y3Bfc2VuZG1zZysweDNhLzB4NTAgbmV0L2lwdjQvdGNwLmM6MTM1OQogaW5ldF9zZW5k
bXNnKzB4YjkvMHgxNTAgbmV0L2lwdjQvYWZfaW5ldC5jOjg1MQogc21jX3NlbmRtc2crMHgy
MmEvMHg1MzAgbmV0L3NtYy9hZl9zbWMuYzoyNzk2CiBzb2NrX3NlbmRtc2dfbm9zZWMgbmV0
L3NvY2tldC5jOjcxOCBbaW5saW5lXQogX19zb2NrX3NlbmRtc2cgbmV0L3NvY2tldC5jOjcz
MyBbaW5saW5lXQogX19fX3N5c19zZW5kbXNnKzB4YWI4LzB4YzcwIG5ldC9zb2NrZXQuYzoy
NTczCiBfX19zeXNfc2VuZG1zZysweDExZC8weDFjMCBuZXQvc29ja2V0LmM6MjYyNwogX19z
eXNfc2VuZG1zZysweDE1MS8weDIwMCBuZXQvc29ja2V0LmM6MjY1OQogZG9fc3lzY2FsbF94
NjQgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTIgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQr
MHhjYi8weDI1MCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo4MwogZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgpSSVA6IDAwMzM6MHg3ZjM2ZWY5YTk2MmQKQ29k
ZTogMDIgYjggZmYgZmYgZmYgZmYgYzMgNjYgMGYgMWYgNDQgMDAgMDAgZjMgMGYgMWUgZmEg
NDggODkgZjggNDggODkgZjcgNDggODkgZDYgNDggODkgY2EgNGQgODkgYzIgNGQgODkgYzgg
NGMgOGIgNGMgMjQgMDggMGYgMDUgJmx0OzQ4Jmd0OyAzZCAwMSBmMCBmZiBmZiA3MyAwMSBj
MyA0OCBjNyBjMSBhOCBmZiBmZiBmZiBmNyBkOCA2NCA4OSAwMSA0OApSU1A6IDAwMmI6MDAw
MDdmMzZmMDhjNWY5OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAw
MDJlClJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZjM2ZWZiYzVmODAgUkNYOiAw
MDAwN2YzNmVmOWE5NjJkClJEWDogMDAwMDAwMDAyNDA0MDA0OSBSU0k6IDAwMDAwMDAwMjAw
MDAyMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDA0ClJCUDogMDAwMDdmMzZlZmE0ZTM3MyBSMDg6
IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClIxMDogMDAwMDAwMDAw
MDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwClIx
MzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAwMDA3ZjM2ZWZiYzVmODAgUjE1OiAwMDAwN2Yz
NmYwOGE2MDAwCiA8L3Rhc2s+Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpJIHVzZSB0aGUgc2FtZSBrZXJuZWwg
YXMgc3l6Ym90IGluc3RhbmNlIHVwc3RyZWFtOiA3ZWIxNzIxNDNkNTUwOGI0ZGE0NjhlZDU5
ZWU4NTdjNmU1ZTAxZGE2Cmtlcm5lbCBjb25maWc6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNw
b3QuY29tL3RleHQ/dGFnPUtlcm5lbENvbmZpZyZhbXA7eD1kYTRiMDRhZTc5OGI3ZWY2CmNv
bXBpbGVyOiBnY2MgdmVyc2lvbiAxMS40LjAKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpV
bmZvcnR1bmF0ZWx5LCB0aGUgbW9kaWZpZWQgc3l6a2FsbGVyIGRvZXMgbm90IGdlbmVyYXRl
IGFuIGVmZmVjdGl2ZSByZXBlYXQgcHJvZ3JhbS4KVGhlIGZvbGxvd2luZyBpcyBteSBhbmFs
eXNpcyBvZiB0aGUgYnVnIGFuZCByZXBhaXIgc3VnZ2VzdGlvbnMsIGhvcGluZyB0byBoZWxw
IHdpdGggdGhlIHJlcGFpciBvZiB0aGUgYnVnOgojIyBSb290IGNhdXNlIGFuYWx5c2lzCjEu
ICoqIG51bGwgcG9pbnRlciBhY2Nlc3MgKiogOiAnc21jX3RjcF9zeW5fcmVjdl9zb2NrJyBm
dW5jdGlvbiBkb2VzIG5vdCBjaGVjayB3aGV0aGVyIHRoZSAnc2snIHBvaW50ZXIgaXMgdmFs
aWQsIGRpcmVjdCBhY2Nlc3MgdG8gaXRzIG1lbWJlciAnc2tfd21lbV9hbGxvYycuCjIuICoq
IE1pc3NpbmcgaW5pdGlhbGl6YXRpb24gKiogOiBUaGUgJ3NrJyBwb2ludGVyIG1heSBub3Qg
YmUgaW5pdGlhbGl6ZWQgY29ycmVjdGx5IG9yIHJldHVybmVkIGluIGFkdmFuY2UgaW4gdGhl
IHdyb25nIHBhdGggKHN1Y2ggYXMgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSBvciBTTUMg
bmVnb3RpYXRpb24gZmFpbHVyZSksIHJlc3VsdGluZyBpbiBhIG51bGwgcG9pbnRlciBmb3Ig
c3Vic2VxdWVudCBvcGVyYXRpb25zLgoKIyMjIFJlcGFpciBzdWdnZXN0aW9ucwoxLiAqKiBu
dWxsIHBvaW50ZXIgY2hlY2sgKiogOiBhZGQgJ2lmICghKSBiZWZvcmUgYWNjZXNzaW5nJyBz
ayAnbWVtYmVyIHNrKSByZXR1cm4gTlVMTDsgJy4KMi4gKiogRXJyb3IgcGF0aCBoYW5kbGlu
ZyAqKiA6IEVuc3VyZSB0aGF0IHJlc291cmNlcyBhcmUgY2xlYW5lZCB1cCBpbiB0aW1lIHdo
ZW4gJ2luZXRfY3NrX2Nsb25lJyBmYWlscyB0byBhdm9pZCBwYXNzaW5nIGludmFsaWQgUG9p
bnRlcnMuClBhdGNoIGV4YW1wbGU6CmRpZmYgLS1naXQgYS9uZXQvc21jL2FmX3NtYy5jIGIv
bmV0L3NtYy9hZl9zbWMuYwotLS0gYS9uZXQvc21jL2FmX3NtYy5jCisrKyBiL25ldC9zbWMv
YWZfc21jLmMKQEAgLTEyOCw2ICsxMjgsOCBAQAogCXN0cnVjdCBzb2NrICpjaGlsZDsKIAog
CXNtYyA9IHNtY19jbGNzb2NrX3VzZXJfZGF0YShzayk7CisJaWYgKCFzbWMpCisJCWdvdG8g
ZHJvcDsgIC8vIEVuc3VyZSB0aGF0IHRoZSBzbWMgcG9pbnRlciBpcyB2YWxpZCBiZWZvcmUg
YWNjZXNzaW5nIGl0cyBtZW1iZXJzCiAKIAlpZiAoUkVBRF9PTkNFKHNrLSZndDtza19hY2tf
YmFja2xvZykgKyBhdG9taWNfcmVhZCgmYW1wO3NtYy0mZ3Q7cXVldWVkX3NtY19ocykgJmd0
OwogCSAgICBzay0mZ3Q7c2tfbWF4X2Fja19iYWNrbG9nKQoKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQpJIGhvcGUgaXQgaGVscHMuCkJlc3QgcmVnYXJkcwpKaWFuemhvdSBaaGFvCnhpbmd3ZWkg
bGVlClpoaXpodW8gVGFuZzwvc3RyZm9yZXhjdHp6Y2hhbmdlQGZveG1haWwuY29tPjwveHJp
dmVuZGVsbDdAZ21haWwuY29tPjwveG54YzIyeG54YzIyQHFxLmNvbT4=


