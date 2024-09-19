Return-Path: <linux-s390+bounces-6141-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96297CDC8
	for <lists+linux-s390@lfdr.de>; Thu, 19 Sep 2024 20:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A870284CBC
	for <lists+linux-s390@lfdr.de>; Thu, 19 Sep 2024 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B920B35;
	Thu, 19 Sep 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIIuPEhF"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB6200AF
	for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771476; cv=none; b=gXW4dQQf6oXp8IxSOXH1aJ7xOkmiSk2/T8CgUxXmvoQOauSJIOKTjy57MLj/YRwRlizl+ll4n4jN8WnW2QnoadXvMO1n3GXIGA/nGxgPmT56pRXHo5vV64pbjoyDCECLW7veaIy5deUhQbwXjRzeIKYwws5oOzYjvQJc/HSShq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771476; c=relaxed/simple;
	bh=01jyuewcGPVdgaxAy3O3+eEYaKoqJKXKhITf88t3jUw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=tmkmu5Ru3tyN7ghXvGSLY/ApIi8cah9F6cxaoc8ryY/HbjSvDFE+2pFQnhoTVBMeMRQ+kWY7qhaHABQ/2rOhYRgI3CvXWhHf1ThpAPGDeys7DjEmKxS7ECLlBgH3rmFUyZc3CJzrFrtlKJfj0pAX9x+EL6V4uw/LnJ8rd6E5L24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIIuPEhF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso665163276.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726771473; x=1727376273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01jyuewcGPVdgaxAy3O3+eEYaKoqJKXKhITf88t3jUw=;
        b=fIIuPEhF52jz9b1AP6xfiqzV2FD82O2nO2WWLTtE2TCEZdQJMjOxVY9iMFCzJQEGuG
         Xlzebm43sbx87oMf+zEMrgAVrXm4JK6wAKyNZYkPfro9qV+bxC8PzFH4qqGg0YEa5kfZ
         FBjwvlJPHnbvSslAE91HDHTngh1u7pUJQrjVpCEWZsp55WqvcvKHpFX6eaOagCY36Ptc
         GULvc+HXNG19RELCwo5+QCZn1QCFZr1dAp3HRk2LBGLOS3d/ShsqkVyAy8uRfFnRVw6j
         7cgqznUNBB2sSpG1ZYHAWKaNgnKRE/WPYA20xGuxeD2lifkEutbd7cJQ3YG1LNyiZQ0V
         v62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771473; x=1727376273;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=01jyuewcGPVdgaxAy3O3+eEYaKoqJKXKhITf88t3jUw=;
        b=QxUQKRPQ4wVazWmHMwYWiMgzArPrXe1FiWnaX0TtdHXvmVhM1z0b5XdaU4rqUBC7iT
         w5kFQ9iaCsuraCOaDUmxmgm2rjj/pGkveVDGqbJcd4pgtghMiHfRxZwkTZTPh6ywtFQk
         Q4QczQUZu6kBZ/i0YXlhIQ01LHXtsuAadVESVBuCTHG6ViytAR8jXPj/kOCJ6JYu+qtP
         GOgF9YEBaxgN7HMmgCHovRRs/+EV4TuSBZU+9NB8yZESVZ8nUBBLyJBf8AB8y5nNys83
         3jffa+xzYU9cw3CpXfXtoX6e+qHZ+mhxTKXnBV1D+H/1kUlCMSTL+WxFPbiz+89T/OLY
         0+kw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ChpNGFbF/bn//5VIhKmAiwzoOlFyHAMEDKSeqxMn6IUtqXbFYiCX2Owp48BJLR8Rd556LpdPPUlT@vger.kernel.org
X-Gm-Message-State: AOJu0YziCPdrxf+htDdB9tuIe7COoRTm7zhceOd98seIFtOBW/j4Db7+
	S15bXxXqa4Jao3Nrl1ocUjd5sASGywvIQQ36Y0SCE7OPmWzkbYvBmZXd2h1bO9VXPKRsTbbrXpY
	hIGA3Q7E4wdcx6ABRdaLDPg==
X-Google-Smtp-Source: AGHT+IFNC3HVOBf94qVbktn3xaQ1XxoZtiBu35ekLRa54eGtVfwl1ixhLr5WJ0azngs4GxmR/MfxZt/JCpRNBHWnfQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:84c9:0:b0:e20:20a5:b40a with SMTP
 id 3f1490d57ef6-e20276ee0dfmr35303276.5.1726771472515; Thu, 19 Sep 2024
 11:44:32 -0700 (PDT)
Date: Thu, 19 Sep 2024 18:44:31 +0000
In-Reply-To: <64fbdf0b-02b9-43cd-a0ba-89e37f2615f8@linux.ibm.com> (message
 from Madhavan Srinivasan on Tue, 17 Sep 2024 11:06:54 +0530)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntikurcwkw.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 2/5] perf: Hoist perf_instruction_pointer() and perf_misc_flags()
From: Colton Lewis <coltonlewis@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	will@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

TWFkaGF2YW4gU3Jpbml2YXNhbiA8bWFkZHlAbGludXguaWJtLmNvbT4gd3JpdGVzOg0KDQo+IE9u
IDkvMTMvMjQgMjoyMSBBTSwgQ29sdG9uIExld2lzIHdyb3RlOg0KPj4gRm9yIGNsYXJpdHksIHJl
bmFtZSB0aGUgYXJjaC1zcGVjaWZpYyBkZWZpbml0aW9ucyBvZiB0aGVzZSBmdW5jdGlvbnMNCj4+
IHRvIHBlcmZfYXJjaF8qIHRvIGRlbm90ZSB0aGV5IGFyZSBhcmNoLXNwZWNpZmMuIERlZmluZSB0
aGUNCj4+IGdlbmVyaWMtbmFtZWQgZnVuY3Rpb25zIGluIG9uZSBwbGFjZSB3aGVyZSB0aGV5IGNh
biBjYWxsIHRoZQ0KPj4gYXJjaC1zcGVjaWZpYyBvbmVzIGFzIG5lZWRlZC4NCg0KPj4gU2lnbmVk
LW9mZi1ieTogQ29sdG9uIExld2lzIDxjb2x0b25sZXdpc0Bnb29nbGUuY29tPg0KPj4gLS0tDQo+
PiAgICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BlcmZfZXZlbnQuaCAgICAgICAgICB8ICA2ICsr
Ky0tLQ0KPj4gICAgYXJjaC9hcm02NC9rZXJuZWwvcGVyZl9jYWxsY2hhaW4uYyAgICAgICAgICAg
fCAgNCArKy0tDQo+PiAgICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGVyZl9ldmVudF9zZXJ2
ZXIuaCB8ICA2ICsrKy0tLQ0KPj4gICAgYXJjaC9wb3dlcnBjL3BlcmYvY29yZS1ib29rM3MuYyAg
ICAgICAgICAgICAgfCAgNCArKy0tDQo+PiAgICBhcmNoL3MzOTAvaW5jbHVkZS9hc20vcGVyZl9l
dmVudC5oICAgICAgICAgICB8ICA2ICsrKy0tLQ0KPj4gICAgYXJjaC9zMzkwL2tlcm5lbC9wZXJm
X2V2ZW50LmMgICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+PiAgICBhcmNoL3g4Ni9ldmVudHMv
Y29yZS5jICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4+ICAgIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BlcmZfZXZlbnQuaCAgICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KPj4gICAg
aW5jbHVkZS9saW51eC9wZXJmX2V2ZW50LmggICAgICAgICAgICAgICAgICAgfCAgOSArKysrKyst
LS0NCj4+ICAgIGtlcm5lbC9ldmVudHMvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MTAgKysrKysrKysrKw0KPj4gICAgMTAgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwg
MjUgZGVsZXRpb25zKC0pDQoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L3BlcmZfZXZlbnQuaCAgDQo+PiBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGVyZl9ldmVudC5o
DQo+PiBpbmRleCBlYjcwNzFjOWViMzQuLjMxYTU1ODRlZDQyMyAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gvYXJtNjQvaW5jbHVkZS9hc20vcGVyZl9ldmVudC5oDQo+PiArKysgYi9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL3BlcmZfZXZlbnQuaA0KPj4gQEAgLTExLDkgKzExLDkgQEANCg0KPj4gICAgI2lm
ZGVmIENPTkZJR19QRVJGX0VWRU5UUw0KPj4gICAgc3RydWN0IHB0X3JlZ3M7DQo+PiAtZXh0ZXJu
IHVuc2lnbmVkIGxvbmcgcGVyZl9pbnN0cnVjdGlvbl9wb2ludGVyKHN0cnVjdCBwdF9yZWdzICpy
ZWdzKTsNCj4+IC1leHRlcm4gdW5zaWduZWQgbG9uZyBwZXJmX21pc2NfZmxhZ3Moc3RydWN0IHB0
X3JlZ3MgKnJlZ3MpOw0KPj4gLSNkZWZpbmUgcGVyZl9taXNjX2ZsYWdzKHJlZ3MpCXBlcmZfbWlz
Y19mbGFncyhyZWdzKQ0KPj4gK2V4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZfYXJjaF9pbnN0cnVj
dGlvbl9wb2ludGVyKHN0cnVjdCBwdF9yZWdzICANCj4+ICpyZWdzKTsNCj4+ICtleHRlcm4gdW5z
aWduZWQgbG9uZyBwZXJmX2FyY2hfbWlzY19mbGFncyhzdHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+
PiArI2RlZmluZSBwZXJmX2FyY2hfbWlzY19mbGFncyhyZWdzKQlwZXJmX21pc2NfZmxhZ3MocmVn
cykNCj4+ICAgICNkZWZpbmUgcGVyZl9hcmNoX2JwZl91c2VyX3B0X3JlZ3MocmVncykgJnJlZ3Mt
PnVzZXJfcmVncw0KPj4gICAgI2VuZGlmDQoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tl
cm5lbC9wZXJmX2NhbGxjaGFpbi5jICANCj4+IGIvYXJjaC9hcm02NC9rZXJuZWwvcGVyZl9jYWxs
Y2hhaW4uYw0KPj4gaW5kZXggZThlZDU2NzNmNDgxLi4wMWE5ZDA4ZmMwMDkgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL2FybTY0L2tlcm5lbC9wZXJmX2NhbGxjaGFpbi5jDQo+PiArKysgYi9hcmNoL2Fy
bTY0L2tlcm5lbC9wZXJmX2NhbGxjaGFpbi5jDQo+PiBAQCAtMzksNyArMzksNyBAQCB2b2lkIHBl
cmZfY2FsbGNoYWluX2tlcm5lbChzdHJ1Y3QgIA0KPj4gcGVyZl9jYWxsY2hhaW5fZW50cnlfY3R4
ICplbnRyeSwNCj4+ICAgIAlhcmNoX3N0YWNrX3dhbGsoY2FsbGNoYWluX3RyYWNlLCBlbnRyeSwg
Y3VycmVudCwgcmVncyk7DQo+PiAgICB9DQoNCj4+IC11bnNpZ25lZCBsb25nIHBlcmZfaW5zdHJ1
Y3Rpb25fcG9pbnRlcihzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4+ICt1bnNpZ25lZCBsb25nIHBl
cmZfYXJjaF9pbnN0cnVjdGlvbl9wb2ludGVyKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gICAg
ew0KPj4gICAgCWlmIChwZXJmX2d1ZXN0X3N0YXRlKCkpDQo+PiAgICAJCXJldHVybiBwZXJmX2d1
ZXN0X2dldF9pcCgpOw0KPj4gQEAgLTQ3LDcgKzQ3LDcgQEAgdW5zaWduZWQgbG9uZyBwZXJmX2lu
c3RydWN0aW9uX3BvaW50ZXIoc3RydWN0IHB0X3JlZ3MgIA0KPj4gKnJlZ3MpDQo+PiAgICAJcmV0
dXJuIGluc3RydWN0aW9uX3BvaW50ZXIocmVncyk7DQo+PiAgICB9DQoNCj4+IC11bnNpZ25lZCBs
b25nIHBlcmZfbWlzY19mbGFncyhzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4+ICt1bnNpZ25lZCBs
b25nIHBlcmZfYXJjaF9taXNjX2ZsYWdzKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gICAgew0K
Pj4gICAgCXVuc2lnbmVkIGludCBndWVzdF9zdGF0ZSA9IHBlcmZfZ3Vlc3Rfc3RhdGUoKTsNCj4+
ICAgIAlpbnQgbWlzYyA9IDA7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL3BlcmZfZXZlbnRfc2VydmVyLmggIA0KPj4gYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
cGVyZl9ldmVudF9zZXJ2ZXIuaA0KPj4gaW5kZXggNTk5NTYxNGU5MDYyLi40MTU4N2QzZjg0NDYg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGVyZl9ldmVudF9zZXJ2
ZXIuaA0KPj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BlcmZfZXZlbnRfc2VydmVy
LmgNCj4+IEBAIC0xMDIsOCArMTAyLDggQEAgc3RydWN0IHBvd2VyX3BtdSB7DQo+PiAgICBpbnQg
X19pbml0IHJlZ2lzdGVyX3Bvd2VyX3BtdShzdHJ1Y3QgcG93ZXJfcG11ICpwbXUpOw0KDQo+PiAg
ICBzdHJ1Y3QgcHRfcmVnczsNCj4+IC1leHRlcm4gdW5zaWduZWQgbG9uZyBwZXJmX21pc2NfZmxh
Z3Moc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0KPj4gLWV4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZf
aW5zdHJ1Y3Rpb25fcG9pbnRlcihzdHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+PiArZXh0ZXJuIHVu
c2lnbmVkIGxvbmcgcGVyZl9hcmNoX21pc2NfZmxhZ3Moc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0K
Pj4gK2V4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZfYXJjaF9pbnN0cnVjdGlvbl9wb2ludGVyKHN0
cnVjdCBwdF9yZWdzICANCj4+ICpyZWdzKTsNCj4+ICAgIGV4dGVybiB1bnNpZ25lZCBsb25nIGlu
dCByZWFkX2JocmIoaW50IG4pOw0KDQo+PiAgICAvKg0KPj4gQEAgLTExMSw3ICsxMTEsNyBAQCBl
eHRlcm4gdW5zaWduZWQgbG9uZyBpbnQgcmVhZF9iaHJiKGludCBuKTsNCj4+ICAgICAqIGlmIHdl
IGhhdmUgaGFyZHdhcmUgUE1VIHN1cHBvcnQuDQo+PiAgICAgKi8NCj4+ICAgICNpZmRlZiBDT05G
SUdfUFBDX1BFUkZfQ1RSUw0KPj4gLSNkZWZpbmUgcGVyZl9taXNjX2ZsYWdzKHJlZ3MpCXBlcmZf
bWlzY19mbGFncyhyZWdzKQ0KPj4gKyNkZWZpbmUgcGVyZl9hcmNoX21pc2NfZmxhZ3MocmVncykJ
cGVyZl9taXNjX2ZsYWdzKHJlZ3MpDQo+PiAgICAjZW5kaWYNCg0KPiBDb21waWxhdGlvbiBmYWls
cyB3aXRoDQoNCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9saW51eC9hcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vcGVyZl9ldmVudC5oOjE0LA0KPiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZyb20gL2xpbnV4L2luY2x1ZGUvbGludXgvcGVyZl9ldmVudC5oOjI1LA0KPiAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gL2xpbnV4L2FyY2gvcG93ZXJwYy9w
ZXJmL2NvcmUtYm9vazNzLmM6MTA6DQo+IC9saW51eC9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
cGVyZl9ldmVudF9zZXJ2ZXIuaDoxMTQ6NDE6IGVycm9yOg0KPiBjb25mbGljdGluZyB0eXBlcyBm
b3IgJ3BlcmZfbWlzY19mbGFncyc7IGhhdmUgJ2xvbmcgdW5zaWduZWQgaW50KHN0cnVjdA0KPiBw
dF9yZWdzICopJw0KPiAgIMKgIDExNCB8ICNkZWZpbmUgcGVyZl9hcmNoX21pc2NfZmxhZ3MocmVn
cynCoMKgwqDCoMKgIHBlcmZfbWlzY19mbGFncyhyZWdzKQ0KPiB8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXn5+fn5+fn5+fn5+fn5+DQo+IC9saW51eC9hcmNoL3Bvd2VycGMvcGVyZi9jb3JlLWJv
b2szcy5jOjIzMzU6MTU6IG5vdGU6IGluIGV4cGFuc2lvbiBvZg0KPiBtYWNybyAncGVyZl9hcmNo
X21pc2NfZmxhZ3MnDQo+ICAgwqAyMzM1IHwgdW5zaWduZWQgbG9uZyBwZXJmX2FyY2hfbWlzY19m
bGFncyhzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gICDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC9saW51eC9pbmNsdWRlL2xp
bnV4L3BlcmZfZXZlbnQuaDoxNjMwOjIyOiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZg0K
PiAncGVyZl9taXNjX2ZsYWdzJyB3aXRoIHR5cGUgJ2xvbmcgdW5zaWduZWQgaW50KHN0cnVjdCBw
ZXJmX2V2ZW50ICosDQo+IHN0cnVjdCBwdF9yZWdzICopJw0KPiAgIMKgMTYzMCB8IGV4dGVybiB1
bnNpZ25lZCBsb25nIHBlcmZfbWlzY19mbGFncyhzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsDQo+
IHN0cnVjdCBwdF9yZWdzICpyZWdzKTsNCj4gICDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+DQoNCg0KPiBUaGlzIGZp
eGVzIHRoZSBmYWlsDQoNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BlcmZfZXZl
bnRfc2VydmVyLmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BlcmZfZXZlbnRf
c2VydmVyLmgNCj4gQEAgLTExMSw3ICsxMTEsNyBAQCBleHRlcm4gdW5zaWduZWQgbG9uZyBpbnQg
cmVhZF9iaHJiKGludCBuKTsNCj4gICDCoCAqIGlmIHdlIGhhdmUgaGFyZHdhcmUgUE1VIHN1cHBv
cnQuDQo+ICAgwqAgKi8NCj4gICDCoCNpZmRlZiBDT05GSUdfUFBDX1BFUkZfQ1RSUw0KPiAtI2Rl
ZmluZSBwZXJmX2FyY2hfbWlzY19mbGFncyhyZWdzKSBwZXJmX21pc2NfZmxhZ3MocmVncykNCj4g
KyNkZWZpbmUgcGVyZl9hcmNoX21pc2NfZmxhZ3MocmVncykgcGVyZl9hcmNoX21pc2NfZmxhZ3Mo
cmVncykNCj4gICDCoCNlbmRpZg0KDQo+ICAgwqAvKg0KDQpUaGFua3MuIERvbmUNCg0KPj4gICAg
LyoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGVyZi9jb3JlLWJvb2szcy5jICANCj4+
IGIvYXJjaC9wb3dlcnBjL3BlcmYvY29yZS1ib29rM3MuYw0KPj4gaW5kZXggNDI4Njc0Njk3NTJk
Li5kYzAxYWE2MDRjYzEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvcGVyZi9jb3JlLWJv
b2szcy5jDQo+PiArKysgYi9hcmNoL3Bvd2VycGMvcGVyZi9jb3JlLWJvb2szcy5jDQo+PiBAQCAt
MjMzMiw3ICsyMzMyLDcgQEAgc3RhdGljIHZvaWQgcmVjb3JkX2FuZF9yZXN0YXJ0KHN0cnVjdCBw
ZXJmX2V2ZW50ICANCj4+ICpldmVudCwgdW5zaWduZWQgbG9uZyB2YWwsDQo+PiAgICAgKiBDYWxs
ZWQgZnJvbSBnZW5lcmljIGNvZGUgdG8gZ2V0IHRoZSBtaXNjIGZsYWdzIChpLmUuIHByb2Nlc3Nv
ciBtb2RlKQ0KPj4gICAgICogZm9yIGFuIGV2ZW50X2lkLg0KPj4gICAgICovDQo+PiAtdW5zaWdu
ZWQgbG9uZyBwZXJmX21pc2NfZmxhZ3Moc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+PiArdW5zaWdu
ZWQgbG9uZyBwZXJmX2FyY2hfbWlzY19mbGFncyhzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4+ICAg
IHsNCj4+ICAgIAl1MzIgZmxhZ3MgPSBwZXJmX2dldF9taXNjX2ZsYWdzKHJlZ3MpOw0KDQo+PiBA
QCAtMjM0Niw3ICsyMzQ2LDcgQEAgdW5zaWduZWQgbG9uZyBwZXJmX21pc2NfZmxhZ3Moc3RydWN0
IHB0X3JlZ3MgKnJlZ3MpDQo+PiAgICAgKiBDYWxsZWQgZnJvbSBnZW5lcmljIGNvZGUgdG8gZ2V0
IHRoZSBpbnN0cnVjdGlvbiBwb2ludGVyDQo+PiAgICAgKiBmb3IgYW4gZXZlbnRfaWQuDQo+PiAg
ICAgKi8NCj4+IC11bnNpZ25lZCBsb25nIHBlcmZfaW5zdHJ1Y3Rpb25fcG9pbnRlcihzdHJ1Y3Qg
cHRfcmVncyAqcmVncykNCj4+ICt1bnNpZ25lZCBsb25nIHBlcmZfYXJjaF9pbnN0cnVjdGlvbl9w
b2ludGVyKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gICAgew0KPj4gICAgCXVuc2lnbmVkIGxv
bmcgc2lhciA9IG1mc3ByKFNQUk5fU0lBUik7DQoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3MzOTAv
aW5jbHVkZS9hc20vcGVyZl9ldmVudC5oICANCj4+IGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL3Bl
cmZfZXZlbnQuaA0KPj4gaW5kZXggOTkxN2UyNzE3YjJiLi5mMmQ4MzI4OWVjN2EgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3MzOTAvaW5jbHVkZS9hc20vcGVyZl9ldmVudC5oDQo+PiArKysgYi9hcmNo
L3MzOTAvaW5jbHVkZS9hc20vcGVyZl9ldmVudC5oDQo+PiBAQCAtMzcsOSArMzcsOSBAQCBleHRl
cm4gc3NpemVfdCBjcHVtZl9ldmVudHNfc3lzZnNfc2hvdyhzdHJ1Y3QgZGV2aWNlICANCj4+ICpk
ZXYsDQoNCj4+ICAgIC8qIFBlcmYgY2FsbGJhY2tzICovDQo+PiAgICBzdHJ1Y3QgcHRfcmVnczsN
Cj4+IC1leHRlcm4gdW5zaWduZWQgbG9uZyBwZXJmX2luc3RydWN0aW9uX3BvaW50ZXIoc3RydWN0
IHB0X3JlZ3MgKnJlZ3MpOw0KPj4gLWV4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZfbWlzY19mbGFn
cyhzdHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+PiAtI2RlZmluZSBwZXJmX21pc2NfZmxhZ3MocmVn
cykgcGVyZl9taXNjX2ZsYWdzKHJlZ3MpDQo+PiArZXh0ZXJuIHVuc2lnbmVkIGxvbmcgcGVyZl9h
cmNoX2luc3RydWN0aW9uX3BvaW50ZXIoc3RydWN0IHB0X3JlZ3MgIA0KPj4gKnJlZ3MpOw0KPj4g
K2V4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZfYXJjaF9taXNjX2ZsYWdzKHN0cnVjdCBwdF9yZWdz
ICpyZWdzKTsNCj4+ICsjZGVmaW5lIHBlcmZfYXJjaF9taXNjX2ZsYWdzKHJlZ3MpIHBlcmZfbWlz
Y19mbGFncyhyZWdzKQ0KPj4gICAgI2RlZmluZSBwZXJmX2FyY2hfYnBmX3VzZXJfcHRfcmVncyhy
ZWdzKSAmcmVncy0+dXNlcl9yZWdzDQoNCj4+ICAgIC8qIFBlcmYgcHRfcmVncyBleHRlbnNpb24g
Zm9yIHNhbXBsZS1kYXRhLWVudHJ5IGluZGljYXRvcnMgKi8NCj4+IGRpZmYgLS1naXQgYS9hcmNo
L3MzOTAva2VybmVsL3BlcmZfZXZlbnQuYyAgDQo+PiBiL2FyY2gvczM5MC9rZXJuZWwvcGVyZl9l
dmVudC5jDQo+PiBpbmRleCA1ZmZmNjI5YjFhODkuLmY5MDAwYWI0OWY0YSAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gvczM5MC9rZXJuZWwvcGVyZl9ldmVudC5jDQo+PiArKysgYi9hcmNoL3MzOTAva2Vy
bmVsL3BlcmZfZXZlbnQuYw0KPj4gQEAgLTU3LDcgKzU3LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgaW5zdHJ1Y3Rpb25fcG9pbnRlcl9ndWVzdChzdHJ1Y3QgIA0KPj4gcHRfcmVncyAqcmVncykN
Cj4+ICAgIAlyZXR1cm4gc2llX2Jsb2NrKHJlZ3MpLT5ncHN3LmFkZHI7DQo+PiAgICB9DQoNCj4+
IC11bnNpZ25lZCBsb25nIHBlcmZfaW5zdHJ1Y3Rpb25fcG9pbnRlcihzdHJ1Y3QgcHRfcmVncyAq
cmVncykNCj4+ICt1bnNpZ25lZCBsb25nIHBlcmZfYXJjaF9pbnN0cnVjdGlvbl9wb2ludGVyKHN0
cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gICAgew0KPj4gICAgCXJldHVybiBpc19pbl9ndWVzdChy
ZWdzKSA/IGluc3RydWN0aW9uX3BvaW50ZXJfZ3Vlc3QocmVncykNCj4+ICAgIAkJCQkgOiBpbnN0
cnVjdGlvbl9wb2ludGVyKHJlZ3MpOw0KPj4gQEAgLTg0LDcgKzg0LDcgQEAgc3RhdGljIHVuc2ln
bmVkIGxvbmcgcGVyZl9taXNjX2ZsYWdzX3NmKHN0cnVjdCBwdF9yZWdzICANCj4+ICpyZWdzKQ0K
Pj4gICAgCXJldHVybiBmbGFnczsNCj4+ICAgIH0NCg0KPj4gLXVuc2lnbmVkIGxvbmcgcGVyZl9t
aXNjX2ZsYWdzKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gK3Vuc2lnbmVkIGxvbmcgcGVyZl9h
cmNoX21pc2NfZmxhZ3Moc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+PiAgICB7DQo+PiAgICAJLyog
Q2hlY2sgaWYgdGhlIGNwdW1fc2YgUE1VIGhhcyBjcmVhdGVkIHRoZSBwdF9yZWdzIHN0cnVjdHVy
ZS4NCj4+ICAgIAkgKiBJbiB0aGlzIGNhc2UsIHBlcmYgbWlzYyBmbGFncyBjYW4gYmUgZWFzaWx5
IGV4dHJhY3RlZC4gIE90aGVyd2lzZSwNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMv
Y29yZS5jIGIvYXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KPj4gaW5kZXggYmUwMTgyM2IxYmI0Li43
NjBhZDA2NzUyN2MgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9ldmVudHMvY29yZS5jDQo+PiBAQCAtMjk0MCw3ICsyOTQwLDcgQEAgc3Rh
dGljIHVuc2lnbmVkIGxvbmcgY29kZV9zZWdtZW50X2Jhc2Uoc3RydWN0ICANCj4+IHB0X3JlZ3Mg
KnJlZ3MpDQo+PiAgICAJcmV0dXJuIDA7DQo+PiAgICB9DQoNCj4+IC11bnNpZ25lZCBsb25nIHBl
cmZfaW5zdHJ1Y3Rpb25fcG9pbnRlcihzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4+ICt1bnNpZ25l
ZCBsb25nIHBlcmZfYXJjaF9pbnN0cnVjdGlvbl9wb2ludGVyKHN0cnVjdCBwdF9yZWdzICpyZWdz
KQ0KPj4gICAgew0KPj4gICAgCWlmIChwZXJmX2d1ZXN0X3N0YXRlKCkpDQo+PiAgICAJCXJldHVy
biBwZXJmX2d1ZXN0X2dldF9pcCgpOw0KPj4gQEAgLTI5NDgsNyArMjk0OCw3IEBAIHVuc2lnbmVk
IGxvbmcgcGVyZl9pbnN0cnVjdGlvbl9wb2ludGVyKHN0cnVjdCAgDQo+PiBwdF9yZWdzICpyZWdz
KQ0KPj4gICAgCXJldHVybiByZWdzLT5pcCArIGNvZGVfc2VnbWVudF9iYXNlKHJlZ3MpOw0KPj4g
ICAgfQ0KDQo+PiAtdW5zaWduZWQgbG9uZyBwZXJmX21pc2NfZmxhZ3Moc3RydWN0IHB0X3JlZ3Mg
KnJlZ3MpDQo+PiArdW5zaWduZWQgbG9uZyBwZXJmX2FyY2hfbWlzY19mbGFncyhzdHJ1Y3QgcHRf
cmVncyAqcmVncykNCj4+ICAgIHsNCj4+ICAgIAl1bnNpZ25lZCBpbnQgZ3Vlc3Rfc3RhdGUgPSBw
ZXJmX2d1ZXN0X3N0YXRlKCk7DQo+PiAgICAJaW50IG1pc2MgPSAwOw0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmZfZXZlbnQuaCAgDQo+PiBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmZfZXZlbnQuaA0KPj4gaW5kZXggOTFiNzM1NzE0MTJmLi5mZWI4N2JmM2QyZTkg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJmX2V2ZW50LmgNCj4+ICsr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmZfZXZlbnQuaA0KPj4gQEAgLTUzNiwxNSArNTM2
LDE1IEBAIHN0cnVjdCB4ODZfcGVyZl9yZWdzIHsNCj4+ICAgIAl1NjQJCSp4bW1fcmVnczsNCj4+
ICAgIH07DQoNCj4+IC1leHRlcm4gdW5zaWduZWQgbG9uZyBwZXJmX2luc3RydWN0aW9uX3BvaW50
ZXIoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0KPj4gLWV4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZf
bWlzY19mbGFncyhzdHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+PiAtI2RlZmluZSBwZXJmX21pc2Nf
ZmxhZ3MocmVncykJcGVyZl9taXNjX2ZsYWdzKHJlZ3MpDQo+PiArZXh0ZXJuIHVuc2lnbmVkIGxv
bmcgcGVyZl9hcmNoX2luc3RydWN0aW9uX3BvaW50ZXIoc3RydWN0IHB0X3JlZ3MgIA0KPj4gKnJl
Z3MpOw0KPj4gK2V4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZfYXJjaF9taXNjX2ZsYWdzKHN0cnVj
dCBwdF9yZWdzICpyZWdzKTsNCj4+ICsjZGVmaW5lIHBlcmZfYXJjaF9taXNjX2ZsYWdzKHJlZ3Mp
CXBlcmZfYXJjaF9taXNjX2ZsYWdzKHJlZ3MpDQoNCj4+ICAgICNpbmNsdWRlIDxhc20vc3RhY2t0
cmFjZS5oPg0KDQo+PiAgICAvKg0KPj4gLSAqIFdlIGFidXNlIGJpdCAzIGZyb20gZmxhZ3MgdG8g
cGFzcyBleGFjdCBpbmZvcm1hdGlvbiwgc2VlICANCj4+IHBlcmZfbWlzY19mbGFncw0KPj4gLSAq
IGFuZCB0aGUgY29tbWVudCB3aXRoIFBFUkZfRUZMQUdTX0VYQUNULg0KPj4gKyAqIFdlIGFidXNl
IGJpdCAzIGZyb20gZmxhZ3MgdG8gcGFzcyBleGFjdCBpbmZvcm1hdGlvbiwgc2VlDQo+PiArICog
cGVyZl9hcmNoX21pc2NfZmxhZ3MoKSBhbmQgdGhlIGNvbW1lbnQgd2l0aCBQRVJGX0VGTEFHU19F
WEFDVC4NCj4+ICAgICAqLw0KPj4gICAgI2RlZmluZSBwZXJmX2FyY2hfZmV0Y2hfY2FsbGVyX3Jl
Z3MocmVncywgX19pcCkJCXsJXA0KPj4gICAgCShyZWdzKS0+aXAgPSAoX19pcCk7CQkJCQlcDQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wZXJmX2V2ZW50LmggYi9pbmNsdWRlL2xpbnV4
L3BlcmZfZXZlbnQuaA0KPj4gaW5kZXggMWE4OTQyMjc3ZGRhLi5kMDYxZTMyN2FkNTQgMTAwNjQ0
DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaA0KPj4gKysrIGIvaW5jbHVkZS9s
aW51eC9wZXJmX2V2ZW50LmgNCj4+IEBAIC0xNjMzLDEwICsxNjMzLDEzIEBAIGV4dGVybiB2b2lk
IHBlcmZfdHBfZXZlbnQodTE2IGV2ZW50X3R5cGUsIHU2NCAgDQo+PiBjb3VudCwgdm9pZCAqcmVj
b3JkLA0KPj4gICAgCQkJICBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2spOw0KPj4gICAgZXh0ZXJu
IHZvaWQgcGVyZl9icF9ldmVudChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQsIHZvaWQgKmRhdGEp
Ow0KDQo+PiAtI2lmbmRlZiBwZXJmX21pc2NfZmxhZ3MNCj4+IC0jIGRlZmluZSBwZXJmX21pc2Nf
ZmxhZ3MocmVncykgXA0KPj4gK2V4dGVybiB1bnNpZ25lZCBsb25nIHBlcmZfbWlzY19mbGFncyhz
dHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+PiArZXh0ZXJuIHVuc2lnbmVkIGxvbmcgcGVyZl9pbnN0
cnVjdGlvbl9wb2ludGVyKHN0cnVjdCBwdF9yZWdzICpyZWdzKTsNCj4+ICsNCj4+ICsjaWZuZGVm
IHBlcmZfYXJjaF9taXNjX2ZsYWdzDQo+PiArIyBkZWZpbmUgcGVyZl9hcmNoX21pc2NfZmxhZ3Mo
cmVncykgXA0KPj4gICAgCQkodXNlcl9tb2RlKHJlZ3MpID8gUEVSRl9SRUNPUkRfTUlTQ19VU0VS
IDogUEVSRl9SRUNPUkRfTUlTQ19LRVJORUwpDQo+PiAtIyBkZWZpbmUgcGVyZl9pbnN0cnVjdGlv
bl9wb2ludGVyKHJlZ3MpCWluc3RydWN0aW9uX3BvaW50ZXIocmVncykNCj4+ICsjIGRlZmluZSBw
ZXJmX2FyY2hfaW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKQlpbnN0cnVjdGlvbl9wb2ludGVyKHJl
Z3MpDQo+PiAgICAjZW5kaWYNCj4+ICAgICNpZm5kZWYgcGVyZl9hcmNoX2JwZl91c2VyX3B0X3Jl
Z3MNCj4+ICAgICMgZGVmaW5lIHBlcmZfYXJjaF9icGZfdXNlcl9wdF9yZWdzKHJlZ3MpIHJlZ3MN
Cj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL2NvcmUuYyBiL2tlcm5lbC9ldmVudHMvY29y
ZS5jDQo+PiBpbmRleCA4YTZjNmJiY2Q2NTguLmVlYWJiZjc5MWE4YyAxMDA2NDQNCj4+IC0tLSBh
L2tlcm5lbC9ldmVudHMvY29yZS5jDQo+PiArKysgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYw0KPj4g
QEAgLTY5MjEsNiArNjkyMSwxNiBAQCB2b2lkIHBlcmZfdW5yZWdpc3Rlcl9ndWVzdF9pbmZvX2Nh
bGxiYWNrcyhzdHJ1Y3QgIA0KPj4gcGVyZl9ndWVzdF9pbmZvX2NhbGxiYWNrcyAqY2JzKQ0KPj4g
ICAgRVhQT1JUX1NZTUJPTF9HUEwocGVyZl91bnJlZ2lzdGVyX2d1ZXN0X2luZm9fY2FsbGJhY2tz
KTsNCj4+ICAgICNlbmRpZg0KDQo+PiArdW5zaWduZWQgbG9uZyBwZXJmX21pc2NfZmxhZ3Moc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpDQo+PiArew0KPj4gKwlyZXR1cm4gcGVyZl9hcmNoX21pc2NfZmxh
Z3MocmVncyk7DQo+PiArfQ0KPj4gKw0KPj4gK3Vuc2lnbmVkIGxvbmcgcGVyZl9pbnN0cnVjdGlv
bl9wb2ludGVyKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gK3sNCj4+ICsJcmV0dXJuIHBlcmZf
YXJjaF9pbnN0cnVjdGlvbl9wb2ludGVyKHJlZ3MpOw0KPj4gK30NCj4+ICsNCj4+ICAgIHN0YXRp
YyB2b2lkDQo+PiAgICBwZXJmX291dHB1dF9zYW1wbGVfcmVncyhzdHJ1Y3QgcGVyZl9vdXRwdXRf
aGFuZGxlICpoYW5kbGUsDQo+PiAgICAJCQlzdHJ1Y3QgcHRfcmVncyAqcmVncywgdTY0IG1hc2sp
DQo=

