Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF72611AC9
	for <lists+linux-s390@lfdr.de>; Fri, 28 Oct 2022 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ1TTO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 28 Oct 2022 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ1TTM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Oct 2022 15:19:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3C23B6B6;
        Fri, 28 Oct 2022 12:19:10 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIsD85011037;
        Fri, 28 Oct 2022 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YOLNPemD6L+g4OU6Kh0TuYCriiLVakCldZGlrY18OtA=;
 b=a9W9U8oT5LKZHuHIly+Lerp4AwQV+LJbvCulvIynW1c7EFCiv6+YAy8PhpWIFiXUghrw
 mIq5q0/nVfIBV0jGFvM+rkJxAK736pUNJoTrK1Cbi/HFkqEeJ7899ZgbzLANN1M+xRH1
 hLU3+kGeV3A/v2CEDSAgCC6SSI1Qmpv2l0JbBFEAXqwGlgUC/t4oldJQmvNpEmkR5nIQ
 IUlWm4HNRAWkizBM5Vh6BcYMSriEIsNVTfmUfE4m/ItmEQw2lAsCEJuuOtQBRW5xw+ch
 VCeNRr5kdi4oOt6+srYQAADjnMg7rpGxswtGBazZ7VLyHCqx0qFJ1gYzbol2g3m8P7Ja Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgms48qb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 19:18:35 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SIsL7k011464;
        Fri, 28 Oct 2022 19:18:35 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgms48qa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 19:18:35 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SJ4S0j007910;
        Fri, 28 Oct 2022 19:18:34 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3kfahghhsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 19:18:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SJIUFW25035446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:18:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2761F5805A;
        Fri, 28 Oct 2022 19:18:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6058B58068;
        Fri, 28 Oct 2022 19:18:29 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.65.225.56])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 19:18:29 +0000 (GMT)
Message-ID: <bb376b2e40cbde282c886557af3f9c44d85df907.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/7] vfio/ccw: move private initialization to callback
From:   Eric Farman <farman@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Fri, 28 Oct 2022 15:18:28 -0400
In-Reply-To: <8f295a4b-416a-dc17-487c-d4c4e309c738@linux.ibm.com>
References: <20221019162135.798901-1-farman@linux.ibm.com>
         <20221019162135.798901-4-farman@linux.ibm.com>
         <8f295a4b-416a-dc17-487c-d4c4e309c738@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y_XlolQ_JdL2GlpvlDMzfs-r-qJ28hoG
X-Proofpoint-ORIG-GUID: HpDsGVuqJ2o2SqBB0nAx3-O2fZ-oXRa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210280120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTI4IGF0IDE0OjUyIC0wNDAwLCBNYXR0aGV3IFJvc2F0byB3cm90ZToK
PiBPbiAxMC8xOS8yMiAxMjoyMSBQTSwgRXJpYyBGYXJtYW4gd3JvdGU6Cj4gPiBUaGVyZSdzIGFs
cmVhZHkgYSBkZXZpY2UgaW5pdGlhbGl6YXRpb24gY2FsbGJhY2sgdGhhdCBpcwo+ID4gdXNlZCB0
byBpbml0aWFsaXplIHRoZSByZWxlYXNlIGNvbXBsZXRpb24gd29ya2Fyb3VuZC4KPiAKPiBBcyBk
aXNjdXNzZWQgb2ZmLWxpc3QsIG1heWJlIGNsYXJpZnkgd2hhdCBjYWxsYmFjayB5b3UncmUgdGFs
a2luZwo+IGFib3V0IGhlcmUgYW5kL29yIHJlZmVyZW5jZSB0aGUgY29tbWl0IHRoYXQgYWRkZWQg
aXQuCgpBZ3JlZWQuIFdpbGwgcG9pbnQgb3V0IHRoYXQgaXQncyBwcml2YXRlLT5yZWxlYXNlX2Nv
bXAsIGludHJvZHVjZWQgd2l0aApjb21taXQgZWJiNzJiNzY1ZmI0OSAoInZmaW8vY2N3OiBVc2Ug
dGhlIG5ldyBkZXZpY2UgbGlmZSBjeWNsZQpoZWxwZXJzIikKCj4gCj4gPiAKPiA+IE1vdmUgdGhl
IG90aGVyIGVsZW1lbnRzIG9mIHRoZSB2ZmlvX2Njd19wcml2YXRlIHN0cnVjdCB0aGF0Cj4gPiBy
ZXF1aXJlIGRpc3RpbmN0IGluaXRpYWxpemF0aW9uIG92ZXIgdG8gdGhhdCByb3V0aW5lLgo+ID4g
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEZhcm1hbiA8ZmFybWFuQGxpbnV4LmlibS5jb20+Cj4g
PiAtLS0KPiA+IMKgZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19kcnYuY8KgwqDCoMKgIHwgNTcg
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gLS0tLQo+ID4gwqBkcml2ZXJzL3MzOTAvY2lv
L3ZmaW9fY2N3X29wcy5jwqDCoMKgwqAgfCA0MyArKysrKysrKysrKysrKysrKysrKysrCj4gPiDC
oGRyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfcHJpdmF0ZS5oIHzCoCA3ICsrKy0KPiA+IMKgMyBm
aWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfZHJ2LmMKPiA+IGIvZHJpdmVy
cy9zMzkwL2Npby92ZmlvX2Njd19kcnYuYwo+ID4gaW5kZXggNGVlOTUzYzhhZTM5Li5jYzllZDJm
ZDk3MGYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X2Rydi5jCj4g
PiArKysgYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X2Rydi5jCj4gPiBAQCAtMjQsMTAgKzI0
LDEwIEBACj4gPiDCoCNpbmNsdWRlICJ2ZmlvX2Njd19wcml2YXRlLmgiCj4gPiDCoAo+ID4gwqBz
dHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqdmZpb19jY3dfd29ya19xOwo+ID4gLXN0YXRpYyBzdHJ1
Y3Qga21lbV9jYWNoZSAqdmZpb19jY3dfaW9fcmVnaW9uOwo+ID4gLXN0YXRpYyBzdHJ1Y3Qga21l
bV9jYWNoZSAqdmZpb19jY3dfY21kX3JlZ2lvbjsKPiA+IC1zdGF0aWMgc3RydWN0IGttZW1fY2Fj
aGUgKnZmaW9fY2N3X3NjaGliX3JlZ2lvbjsKPiA+IC1zdGF0aWMgc3RydWN0IGttZW1fY2FjaGUg
KnZmaW9fY2N3X2Nyd19yZWdpb247Cj4gPiArc3RydWN0IGttZW1fY2FjaGUgKnZmaW9fY2N3X2lv
X3JlZ2lvbjsKPiA+ICtzdHJ1Y3Qga21lbV9jYWNoZSAqdmZpb19jY3dfY21kX3JlZ2lvbjsKPiA+
ICtzdHJ1Y3Qga21lbV9jYWNoZSAqdmZpb19jY3dfc2NoaWJfcmVnaW9uOwo+ID4gK3N0cnVjdCBr
bWVtX2NhY2hlICp2ZmlvX2Njd19jcndfcmVnaW9uOwo+ID4gwqAKPiA+IMKgZGVidWdfaW5mb190
ICp2ZmlvX2Njd19kZWJ1Z19tc2dfaWQ7Cj4gPiDCoGRlYnVnX2luZm9fdCAqdmZpb19jY3dfZGVi
dWdfdHJhY2VfaWQ7Cj4gPiBAQCAtNzQsNyArNzQsNyBAQCBpbnQgdmZpb19jY3dfc2NoX3F1aWVz
Y2Uoc3RydWN0IHN1YmNoYW5uZWwgKnNjaCkKPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0
Owo+ID4gwqB9Cj4gPiDCoAo+ID4gLXN0YXRpYyB2b2lkIHZmaW9fY2N3X3NjaF9pb190b2RvKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiA+ICt2b2lkIHZmaW9fY2N3X3NjaF9pb190b2RvKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCB2ZmlvX2Njd19wcml2YXRlICpwcml2YXRlOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBp
cmIgKmlyYjsKPiA+IEBAIC0xMTAsNyArMTEwLDcgQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfc2No
X2lvX3RvZG8oc3RydWN0Cj4gPiB3b3JrX3N0cnVjdCAqd29yaykKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZXZlbnRmZF9zaWduYWwocHJpdmF0ZS0+aW9fdHJpZ2dlciwgMSk7
Cj4gPiDCoH0KPiA+IMKgCj4gPiAtc3RhdGljIHZvaWQgdmZpb19jY3dfY3J3X3RvZG8oc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gK3ZvaWQgdmZpb19jY3dfY3J3X3RvZG8oc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQo+ID4gwqB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHZmaW9f
Y2N3X3ByaXZhdGUgKnByaXZhdGU7Cj4gPiDCoAo+ID4gQEAgLTE1NCw1MiArMTU0LDcgQEAgc3Rh
dGljIHN0cnVjdCB2ZmlvX2Njd19wcml2YXRlCj4gPiAqdmZpb19jY3dfYWxsb2NfcHJpdmF0ZShz
dHJ1Y3Qgc3ViY2hhbm5lbCAqc2NoKQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICghcHJpdmF0ZSkK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVOT01F
TSk7Cj4gCj4gTm90IHN1cmUgd2UgcmVhbGx5IHN0aWxsIG5lZWQgdmZpb19jY3dfYWxsb2NfcHJp
dmF0ZSgpIG5vdyBvciB3aGV0aGVyCj4geW91IGNhbiBqdXN0IGt6YWxsb2MoKSBpbmxpbmUgcmln
aHQgaW4gdmZpb19jY3dfc2NoX3Byb2JlKCkKCkZhaXIuIEl0IGVuZHMgdXAgZW5kcyB1cCBnZXR0
aW5nIHNjcmFwcGVkIGluIHBhdGNoIDYgYW55d2F5LCBidXQgdGhhdAptaWdodCBjbGVhbiB0aGlu
Z3MgdXAganVzdCBhIHNtaWRnZSBtb3JlLiBXaWxsIGdpdmUgaXQgYSB3aGlybC4KCj4gRWl0aGVy
IHdheToKPiAKPiBSZXZpZXdlZC1ieTogTWF0dGhldyBSb3NhdG8gPG1qcm9zYXRvQGxpbnV4Lmli
bS5jb20+CgpUaGFua3MhCgo+IAo+IAo+ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoG11dGV4X2lu
aXQoJnByaXZhdGUtPmlvX211dGV4KTsKPiA+IC3CoMKgwqDCoMKgwqDCoHByaXZhdGUtPnN0YXRl
ID0gVkZJT19DQ1dfU1RBVEVfU1RBTkRCWTsKPiA+IC3CoMKgwqDCoMKgwqDCoElOSVRfTElTVF9I
RUFEKCZwcml2YXRlLT5jcncpOwo+ID4gLcKgwqDCoMKgwqDCoMKgSU5JVF9XT1JLKCZwcml2YXRl
LT5pb193b3JrLCB2ZmlvX2Njd19zY2hfaW9fdG9kbyk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBJTklU
X1dPUksoJnByaXZhdGUtPmNyd193b3JrLCB2ZmlvX2Njd19jcndfdG9kbyk7Cj4gPiAtCj4gPiAt
wqDCoMKgwqDCoMKgwqBwcml2YXRlLT5jcC5ndWVzdF9jcCA9IGtjYWxsb2MoQ0NXQ0hBSU5fTEVO
X01BWCwKPiA+IHNpemVvZihzdHJ1Y3QgY2N3MSksCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQ
X0tFUk5FTCk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXByaXZhdGUtPmNwLmd1ZXN0X2NwKQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2ZyZWVfcHJpdmF0ZTsK
PiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoHByaXZhdGUtPmlvX3JlZ2lvbiA9IGttZW1fY2FjaGVf
emFsbG9jKHZmaW9fY2N3X2lvX3JlZ2lvbiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgR0ZQX0tFUk5FTCB8Cj4gPiBHRlBfRE1BKTsKPiA+IC3CoMKgwqDCoMKgwqDCoGlm
ICghcHJpdmF0ZS0+aW9fcmVnaW9uKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdvdG8gb3V0X2ZyZWVfY3A7Cj4gPiAtCj4gPiAtwqDCoMKgwqDCoMKgwqBwcml2YXRlLT5jbWRf
cmVnaW9uID0KPiA+IGttZW1fY2FjaGVfemFsbG9jKHZmaW9fY2N3X2NtZF9yZWdpb24sCj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9LRVJORUwgfAo+ID4gR0ZQ
X0RNQSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXByaXZhdGUtPmNtZF9yZWdpb24pCj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZnJlZV9pbzsKPiA+IC0KPiA+
IC3CoMKgwqDCoMKgwqDCoHByaXZhdGUtPnNjaGliX3JlZ2lvbiA9Cj4gPiBrbWVtX2NhY2hlX3ph
bGxvYyh2ZmlvX2Njd19zY2hpYl9yZWdpb24sCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwgfAo+ID4gR0ZQX0RNQSk7Cj4gPiAtCj4gPiAtwqDC
oMKgwqDCoMKgwqBpZiAoIXByaXZhdGUtPnNjaGliX3JlZ2lvbikKPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlX2NtZDsKPiA+IC0KPiA+IC3CoMKgwqDCoMKg
wqDCoHByaXZhdGUtPmNyd19yZWdpb24gPQo+ID4ga21lbV9jYWNoZV96YWxsb2ModmZpb19jY3df
Y3J3X3JlZ2lvbiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgR0ZQ
X0tFUk5FTCB8Cj4gPiBHRlBfRE1BKTsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoGlmICghcHJp
dmF0ZS0+Y3J3X3JlZ2lvbikKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IG91dF9mcmVlX3NjaGliOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBwcml2YXRlOwo+ID4g
LQo+ID4gLW91dF9mcmVlX3NjaGliOgo+ID4gLcKgwqDCoMKgwqDCoMKga21lbV9jYWNoZV9mcmVl
KHZmaW9fY2N3X3NjaGliX3JlZ2lvbiwgcHJpdmF0ZS0KPiA+ID5zY2hpYl9yZWdpb24pOwo+ID4g
LW91dF9mcmVlX2NtZDoKPiA+IC3CoMKgwqDCoMKgwqDCoGttZW1fY2FjaGVfZnJlZSh2ZmlvX2Nj
d19jbWRfcmVnaW9uLCBwcml2YXRlLT5jbWRfcmVnaW9uKTsKPiA+IC1vdXRfZnJlZV9pbzoKPiA+
IC3CoMKgwqDCoMKgwqDCoGttZW1fY2FjaGVfZnJlZSh2ZmlvX2Njd19pb19yZWdpb24sIHByaXZh
dGUtPmlvX3JlZ2lvbik7Cj4gPiAtb3V0X2ZyZWVfY3A6Cj4gPiAtwqDCoMKgwqDCoMKgwqBrZnJl
ZShwcml2YXRlLT5jcC5ndWVzdF9jcCk7Cj4gPiAtb3V0X2ZyZWVfcHJpdmF0ZToKPiA+IC3CoMKg
wqDCoMKgwqDCoG11dGV4X2Rlc3Ryb3koJnByaXZhdGUtPmlvX211dGV4KTsKPiA+IC3CoMKgwqDC
oMKgwqDCoGtmcmVlKHByaXZhdGUpOwo+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIo
LUVOT01FTSk7Cj4gPiDCoH0KPiA+IMKgCj4gPiDCoHN0YXRpYyB2b2lkIHZmaW9fY2N3X2ZyZWVf
cHJpdmF0ZShzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZQo+ID4gKnByaXZhdGUpCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19vcHMuYwo+ID4gYi9kcml2ZXJzL3MzOTAv
Y2lvL3ZmaW9fY2N3X29wcy5jCj4gPiBpbmRleCBjZjM4M2M3MjlkNTMuLjYyNmI4ZWIzNTA3YiAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfb3BzLmMKPiA+ICsrKyBi
L2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfb3BzLmMKPiA+IEBAIC01MCw4ICs1MCw1MSBAQCBz
dGF0aWMgaW50IHZmaW9fY2N3X21kZXZfaW5pdF9kZXYoc3RydWN0Cj4gPiB2ZmlvX2RldmljZSAq
dmRldikKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0
ZSA9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRhaW5lcl9vZih2ZGV2
LCBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSwgdmRldik7Cj4gPiDCoAo+ID4gK8KgwqDCoMKgwqDC
oMKgbXV0ZXhfaW5pdCgmcHJpdmF0ZS0+aW9fbXV0ZXgpOwo+ID4gK8KgwqDCoMKgwqDCoMKgcHJp
dmF0ZS0+c3RhdGUgPSBWRklPX0NDV19TVEFURV9TVEFOREJZOwo+ID4gK8KgwqDCoMKgwqDCoMKg
SU5JVF9MSVNUX0hFQUQoJnByaXZhdGUtPmNydyk7Cj4gPiArwqDCoMKgwqDCoMKgwqBJTklUX1dP
UksoJnByaXZhdGUtPmlvX3dvcmssIHZmaW9fY2N3X3NjaF9pb190b2RvKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoElOSVRfV09SSygmcHJpdmF0ZS0+Y3J3X3dvcmssIHZmaW9fY2N3X2Nyd190b2RvKTsK
PiA+IMKgwqDCoMKgwqDCoMKgwqBpbml0X2NvbXBsZXRpb24oJnByaXZhdGUtPnJlbGVhc2VfY29t
cCk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBwcml2YXRlLT5jcC5ndWVzdF9jcCA9IGtjYWxs
b2MoQ0NXQ0hBSU5fTEVOX01BWCwKPiA+IHNpemVvZihzdHJ1Y3QgY2N3MSksCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXByaXZhdGUt
PmNwLmd1ZXN0X2NwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0
X2ZyZWVfcHJpdmF0ZTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHByaXZhdGUtPmlvX3JlZ2lv
biA9IGttZW1fY2FjaGVfemFsbG9jKHZmaW9fY2N3X2lvX3JlZ2lvbiwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCB8Cj4gPiBHRlBfRE1BKTsKPiA+ICvC
oMKgwqDCoMKgwqDCoGlmICghcHJpdmF0ZS0+aW9fcmVnaW9uKQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2ZyZWVfY3A7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqBwcml2YXRlLT5jbWRfcmVnaW9uID0KPiA+IGttZW1fY2FjaGVfemFsbG9jKHZmaW9fY2N3X2Nt
ZF9yZWdpb24sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9L
RVJORUwgfAo+ID4gR0ZQX0RNQSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXByaXZhdGUtPmNt
ZF9yZWdpb24pCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZnJl
ZV9pbzsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHByaXZhdGUtPnNjaGliX3JlZ2lvbiA9Cj4g
PiBrbWVtX2NhY2hlX3phbGxvYyh2ZmlvX2Njd19zY2hpYl9yZWdpb24sCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwgfAo+ID4gR0ZQX0RNQSk7
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXByaXZhdGUtPnNjaGliX3JlZ2lvbikKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlX2NtZDsKPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqDCoHByaXZhdGUtPmNyd19yZWdpb24gPQo+ID4ga21lbV9jYWNoZV96YWxsb2Mo
dmZpb19jY3dfY3J3X3JlZ2lvbiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgR0ZQX0tFUk5FTCB8Cj4gPiBHRlBfRE1BKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICgh
cHJpdmF0ZS0+Y3J3X3JlZ2lvbikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBn
b3RvIG91dF9mcmVlX3NjaGliOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+
ID4gKwo+ID4gK291dF9mcmVlX3NjaGliOgo+ID4gK8KgwqDCoMKgwqDCoMKga21lbV9jYWNoZV9m
cmVlKHZmaW9fY2N3X3NjaGliX3JlZ2lvbiwgcHJpdmF0ZS0KPiA+ID5zY2hpYl9yZWdpb24pOwo+
ID4gK291dF9mcmVlX2NtZDoKPiA+ICvCoMKgwqDCoMKgwqDCoGttZW1fY2FjaGVfZnJlZSh2Zmlv
X2Njd19jbWRfcmVnaW9uLCBwcml2YXRlLT5jbWRfcmVnaW9uKTsKPiA+ICtvdXRfZnJlZV9pbzoK
PiA+ICvCoMKgwqDCoMKgwqDCoGttZW1fY2FjaGVfZnJlZSh2ZmlvX2Njd19pb19yZWdpb24sIHBy
aXZhdGUtPmlvX3JlZ2lvbik7Cj4gPiArb3V0X2ZyZWVfY3A6Cj4gPiArwqDCoMKgwqDCoMKgwqBr
ZnJlZShwcml2YXRlLT5jcC5ndWVzdF9jcCk7Cj4gPiArb3V0X2ZyZWVfcHJpdmF0ZToKPiA+ICvC
oMKgwqDCoMKgwqDCoG11dGV4X2Rlc3Ryb3koJnByaXZhdGUtPmlvX211dGV4KTsKPiA+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4gwqB9Cj4gPiDCoAo+ID4gwqBzdGF0aWMgaW50
IHZmaW9fY2N3X21kZXZfcHJvYmUoc3RydWN0IG1kZXZfZGV2aWNlICptZGV2KQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfcHJpdmF0ZS5oCj4gPiBiL2RyaXZlcnMv
czM5MC9jaW8vdmZpb19jY3dfcHJpdmF0ZS5oCj4gPiBpbmRleCAwZmRmZjE0MzUyMzAuLmIzNTk0
MDA1NzA3MyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfcHJpdmF0
ZS5oCj4gPiArKysgYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X3ByaXZhdGUuaAo+ID4gQEAg
LTExNiw2ICsxMTYsOCBAQCBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSB7Cj4gPiDCoH0gX19hbGln
bmVkKDgpOwo+ID4gwqAKPiA+IMKgaW50IHZmaW9fY2N3X3NjaF9xdWllc2NlKHN0cnVjdCBzdWJj
aGFubmVsICpzY2gpOwo+ID4gK3ZvaWQgdmZpb19jY3dfc2NoX2lvX3RvZG8oc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKTsKPiA+ICt2b2lkIHZmaW9fY2N3X2Nyd190b2RvKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yayk7Cj4gPiDCoAo+ID4gwqBleHRlcm4gc3RydWN0IG1kZXZfZHJpdmVyIHZmaW9f
Y2N3X21kZXZfZHJpdmVyOwo+ID4gwqAKPiA+IEBAIC0xNjMsNyArMTY1LDEwIEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCB2ZmlvX2Njd19mc21fZXZlbnQoc3RydWN0Cj4gPiB2ZmlvX2Njd19wcml2YXRl
ICpwcml2YXRlLAo+ID4gwqB9Cj4gPiDCoAo+ID4gwqBleHRlcm4gc3RydWN0IHdvcmtxdWV1ZV9z
dHJ1Y3QgKnZmaW9fY2N3X3dvcmtfcTsKPiA+IC0KPiA+ICtleHRlcm4gc3RydWN0IGttZW1fY2Fj
aGUgKnZmaW9fY2N3X2lvX3JlZ2lvbjsKPiA+ICtleHRlcm4gc3RydWN0IGttZW1fY2FjaGUgKnZm
aW9fY2N3X2NtZF9yZWdpb247Cj4gPiArZXh0ZXJuIHN0cnVjdCBrbWVtX2NhY2hlICp2ZmlvX2Nj
d19zY2hpYl9yZWdpb247Cj4gPiArZXh0ZXJuIHN0cnVjdCBrbWVtX2NhY2hlICp2ZmlvX2Njd19j
cndfcmVnaW9uOwo+ID4gwqAKPiA+IMKgLyogczM5MCBkZWJ1ZyBmZWF0dXJlLCBzaW1pbGFyIHRv
IGJhc2UgY2lvICovCj4gPiDCoGV4dGVybiBkZWJ1Z19pbmZvX3QgKnZmaW9fY2N3X2RlYnVnX21z
Z19pZDsKPiAKCg==

