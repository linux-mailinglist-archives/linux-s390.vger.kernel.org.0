Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFD6102BC
	for <lists+linux-s390@lfdr.de>; Thu, 27 Oct 2022 22:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiJ0UdW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 27 Oct 2022 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiJ0UdV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Oct 2022 16:33:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7940900FE;
        Thu, 27 Oct 2022 13:33:19 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKLLtl005486;
        Thu, 27 Oct 2022 20:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dM2hsnX47ZoLplJ4JmIomkgCl3XslJUxMwPDn3gg6fI=;
 b=A1G6ehq7TcAvEAGgteuqhJwICyHXJWV7fmU/ECwfFTUMPFdJ1e8VyCdN9syDSZRj+xIO
 bAOck/Ws8PdxysZbU9rBlAWK2jbx3RUWqhI0dxrtUJERhMaICDkAQwI7v0jzD90YgFbt
 dfs4vvEZccENA2cqzdyxqhAPbllUP1C027nQWnHmcHUinLNYnKblenbtCt49pDbifAZ7
 WeAgrp8Wwd0Av9BHcMo5EvkcFmoNivSYn4csEei14EDIfYO0g7wiaHJLr8ar//6Eu3PZ
 lgvRkCQWtaHL3mRWSklvzBE4uQnvUuoTLRH8LKmEvncy7pqg0qswfZ8qkNujPq/m5OYv fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kg0xw08tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 20:32:12 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29RKMlPc008303;
        Thu, 27 Oct 2022 20:32:11 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kg0xw08t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 20:32:11 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29RKKK9w018187;
        Thu, 27 Oct 2022 20:32:10 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3kfahg9jrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 20:32:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29RKW8PG20316692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 20:32:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9778A58054;
        Thu, 27 Oct 2022 20:32:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C8845806F;
        Thu, 27 Oct 2022 20:32:04 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.65.225.56])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Oct 2022 20:32:04 +0000 (GMT)
Message-ID: <f5f4587f57db7f59d027bd5e1068e4eb7eaa5937.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/7] vfio/ccw: create a parent struct
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
Date:   Thu, 27 Oct 2022 16:32:03 -0400
In-Reply-To: <20221019162135.798901-2-farman@linux.ibm.com>
References: <20221019162135.798901-1-farman@linux.ibm.com>
         <20221019162135.798901-2-farman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b9a5tNzuBGRLtA3kALPGwvTcH48TI_1S
X-Proofpoint-GUID: cupFNfORx_mLBlYT75b3yNAP0T6TuJX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTE5IGF0IDE4OjIxICswMjAwLCBFcmljIEZhcm1hbiB3cm90ZToKPiBN
b3ZlIHRoZSBzdHVmZiBhc3NvY2lhdGVkIHdpdGggdGhlIG1kZXYgcGFyZW50IChhbmQgdGh1cyB0
aGUKPiBzdWJjaGFubmVsIHN0cnVjdCkgaW50byBpdHMgb3duIHN0cnVjdCwgYW5kIGxlYXZlIHRo
ZSByZXN0IGluCj4gdGhlIGV4aXN0aW5nIHByaXZhdGUgc3RydWN0dXJlLgo+IAo+IFRoZSBzdWJj
aGFubmVsIHdpbGwgcG9pbnQgdG8gdGhlIHBhcmVudCwgYW5kIHRoZSBwYXJlbnQgd2lsbCBwb2lu
dAo+IHRvIHRoZSBwcml2YXRlLCBmb3IgdGhlIGFyZWFzIHdoZXJlIG9uZSBvciBib3RoIGFyZSBu
ZWVkZWQuIEZ1cnRoZXIKPiBzZXBhcmF0aW9uIG9mIHRoZXNlIHN0cnVjdHMgd2lsbCBmb2xsb3cu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBGYXJtYW4gPGZhcm1hbkBsaW51eC5pYm0uY29tPgo+
IC0tLQo+IMKgZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19kcnYuY8KgwqDCoMKgIHwgMTA0ICsr
KysrKysrKysrKysrKysrKysrLS0tLS0tCj4gLS0KPiDCoGRyaXZlcnMvczM5MC9jaW8vdmZpb19j
Y3dfb3BzLmPCoMKgwqDCoCB8wqDCoCA5ICsrLQo+IMKgZHJpdmVycy9zMzkwL2Npby92ZmlvX2Nj
d19wYXJlbnQuaMKgIHzCoCAyOCArKysrKysrKwo+IMKgZHJpdmVycy9zMzkwL2Npby92ZmlvX2Nj
d19wcml2YXRlLmggfMKgwqAgNSAtLQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxMTIgaW5zZXJ0aW9u
cygrKSwgMzQgZGVsZXRpb25zKC0pCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zMzkw
L2Npby92ZmlvX2Njd19wYXJlbnQuaAo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3MzOTAvY2lv
L3ZmaW9fY2N3X2Rydi5jCj4gYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X2Rydi5jCj4gaW5k
ZXggN2Y1NDAyZmU4NTdhLi42MzQ3NjBjYTBkZWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zMzkw
L2Npby92ZmlvX2Njd19kcnYuYwo+ICsrKyBiL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfZHJ2
LmMKCi4uLnNuaXAuLi4KCj4gQEAgLTIxMywxOCArMjQxLDI4IEBAIHN0YXRpYyBpbnQgdmZpb19j
Y3dfc2NoX3Byb2JlKHN0cnVjdCBzdWJjaGFubmVsCj4gKnNjaCkKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAK
PiArwqDCoMKgwqDCoMKgwqBwYXJlbnQgPSBremFsbG9jKHNpemVvZigqcGFyZW50KSwgR0ZQX0tF
Uk5FTCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihwYXJlbnQpKQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRSX0VSUihwYXJlbnQpOwo+ICsKPiArwqDCoMKg
wqDCoMKgwqBwYXJlbnQtPmRldi5yZWxlYXNlID0gJnZmaW9fY2N3X2ZyZWVfcGFyZW50Owo+ICvC
oMKgwqDCoMKgwqDCoGRldmljZV9pbml0aWFsaXplKCZwYXJlbnQtPmRldik7Cj4gKwoKT29wcy4g
VGhpcyBzaG91bGQgZWl0aGVyIGJlIGRldmljZV9yZWdpc3Rlciwgb3IgSSBuZWVkZWQgYSBkZXZp
Y2VfYWRkCnNvbWV3aGVyZSBhbG9uZyB0aGUgd2F5LiBUaGVyZSdzIG5vIG5lZWQgdG8gc2VwYXJh
dGUgdGhlbSwgc28gdGhlCmZvcm1lciBpcyBwcm9iYWJseSBiZXR0ZXIsIGJ1dCBJIHN0aWxsIG5l
ZWQgc29tZSBhZGRpdGlvbmFsIGxvZ2ljIHRvCmxpbmsgdGhpcyBiYWNrIHRvIHRoZSBjc3MgZHJp
dmVyLgoKPiDCoMKgwqDCoMKgwqDCoMKgcHJpdmF0ZSA9IHZmaW9fY2N3X2FsbG9jX3ByaXZhdGUo
c2NoKTsKPiAtwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHByaXZhdGUpKQo+ICvCoMKgwqDCoMKg
wqDCoGlmIChJU19FUlIocHJpdmF0ZSkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHV0X2RldmljZSgmcGFyZW50LT5kZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIFBUUl9FUlIocHJpdmF0ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+IMKgCj4g
LcKgwqDCoMKgwqDCoMKgZGV2X3NldF9kcnZkYXRhKCZzY2gtPmRldiwgcHJpdmF0ZSk7Cj4gK8Kg
wqDCoMKgwqDCoMKgZGV2X3NldF9kcnZkYXRhKCZzY2gtPmRldiwgcGFyZW50KTsKPiArwqDCoMKg
wqDCoMKgwqBkZXZfc2V0X2RydmRhdGEoJnBhcmVudC0+ZGV2LCBwcml2YXRlKTsKPiDCoAo+IC3C
oMKgwqDCoMKgwqDCoHByaXZhdGUtPm1kZXZfdHlwZS5zeXNmc19uYW1lID0gImlvIjsKPiAtwqDC
oMKgwqDCoMKgwqBwcml2YXRlLT5tZGV2X3R5cGUucHJldHR5X25hbWUgPSAiSS9PIHN1YmNoYW5u
ZWwgKE5vbi1RRElPKSI7Cj4gLcKgwqDCoMKgwqDCoMKgcHJpdmF0ZS0+bWRldl90eXBlc1swXSA9
ICZwcml2YXRlLT5tZGV2X3R5cGU7Cj4gLcKgwqDCoMKgwqDCoMKgcmV0ID0gbWRldl9yZWdpc3Rl
cl9wYXJlbnQoJnByaXZhdGUtPnBhcmVudCwgJnNjaC0+ZGV2LAo+ICvCoMKgwqDCoMKgwqDCoHBh
cmVudC0+bWRldl90eXBlLnN5c2ZzX25hbWUgPSAiaW8iOwo+ICvCoMKgwqDCoMKgwqDCoHBhcmVu
dC0+bWRldl90eXBlLnByZXR0eV9uYW1lID0gIkkvTyBzdWJjaGFubmVsIChOb24tUURJTykiOwo+
ICvCoMKgwqDCoMKgwqDCoHBhcmVudC0+bWRldl90eXBlc1swXSA9ICZwYXJlbnQtPm1kZXZfdHlw
ZTsKPiArwqDCoMKgwqDCoMKgwqByZXQgPSBtZGV2X3JlZ2lzdGVyX3BhcmVudCgmcGFyZW50LT5w
YXJlbnQsICZzY2gtPmRldiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmdmZpb19jY3dfbWRldl9kcml2ZXIsCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwcml2YXRlLT5tZGV2X3R5cGVzLCAxKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhcmVudC0+
bWRldl90eXBlcywgMSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlOwo+IMKgCj4gQEAgLTIzNCwyMCArMjcy
LDI0IEBAIHN0YXRpYyBpbnQgdmZpb19jY3dfc2NoX3Byb2JlKHN0cnVjdCBzdWJjaGFubmVsCj4g
KnNjaCkKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqAKPiDCoG91dF9mcmVlOgo+ICvC
oMKgwqDCoMKgwqDCoGRldl9zZXRfZHJ2ZGF0YSgmcGFyZW50LT5kZXYsIE5VTEwpOwo+IMKgwqDC
oMKgwqDCoMKgwqBkZXZfc2V0X2RydmRhdGEoJnNjaC0+ZGV2LCBOVUxMKTsKPiDCoMKgwqDCoMKg
wqDCoMKgdmZpb19jY3dfZnJlZV9wcml2YXRlKHByaXZhdGUpOwo+ICvCoMKgwqDCoMKgwqDCoHB1
dF9kZXZpY2UoJnBhcmVudC0+ZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDC
oH0KPiDCoAo+IMKgc3RhdGljIHZvaWQgdmZpb19jY3dfc2NoX3JlbW92ZShzdHJ1Y3Qgc3ViY2hh
bm5lbCAqc2NoKQo+IMKgewo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCB2ZmlvX2Njd19wcml2YXRl
ICpwcml2YXRlID0gZGV2X2dldF9kcnZkYXRhKCZzY2gtCj4gPmRldik7Cj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IHZmaW9fY2N3X3BhcmVudCAqcGFyZW50ID0gZGV2X2dldF9kcnZkYXRhKCZzY2gt
PmRldik7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHZmaW9fY2N3X3ByaXZhdGUgKnByaXZhdGUg
PSBkZXZfZ2V0X2RydmRhdGEoJnBhcmVudC0KPiA+ZGV2KTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oG1kZXZfdW5yZWdpc3Rlcl9wYXJlbnQoJnByaXZhdGUtPnBhcmVudCk7Cj4gK8KgwqDCoMKgwqDC
oMKgbWRldl91bnJlZ2lzdGVyX3BhcmVudCgmcGFyZW50LT5wYXJlbnQpOwo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoGRldl9zZXRfZHJ2ZGF0YSgmc2NoLT5kZXYsIE5VTEwpOwo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoHZmaW9fY2N3X2ZyZWVfcHJpdmF0ZShwcml2YXRlKTsKPiArwqDCoMKgwqDCoMKg
wqBwdXRfZGV2aWNlKCZwYXJlbnQtPmRldik7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgVkZJT19D
Q1dfTVNHX0VWRU5UKDQsICJ1bmJvdW5kIGZyb20gc3ViY2hhbm5lbCAleC4leC4lMDR4XG4iLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2No
LT5zY2hpZC5jc3NpZCwgc2NoLT5zY2hpZC5zc2lkLAo+IEBAIC0yNTYsNyArMjk4LDExIEBAIHN0
YXRpYyB2b2lkIHZmaW9fY2N3X3NjaF9yZW1vdmUoc3RydWN0Cj4gc3ViY2hhbm5lbCAqc2NoKQo+
IMKgCj4gwqBzdGF0aWMgdm9pZCB2ZmlvX2Njd19zY2hfc2h1dGRvd24oc3RydWN0IHN1YmNoYW5u
ZWwgKnNjaCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAq
cHJpdmF0ZSA9IGRldl9nZXRfZHJ2ZGF0YSgmc2NoLQo+ID5kZXYpOwo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCB2ZmlvX2Njd19wYXJlbnQgKnBhcmVudCA9IGRldl9nZXRfZHJ2ZGF0YSgmc2NoLT5k
ZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB2ZmlvX2Njd19wcml2YXRlICpwcml2YXRlID0g
ZGV2X2dldF9kcnZkYXRhKCZwYXJlbnQtCj4gPmRldik7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlm
IChXQVJOX09OKCFwcml2YXRlKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHZmaW9fY2N3X2ZzbV9ldmVudChwcml2YXRlLCBW
RklPX0NDV19FVkVOVF9DTE9TRSk7Cj4gwqDCoMKgwqDCoMKgwqDCoHZmaW9fY2N3X2ZzbV9ldmVu
dChwcml2YXRlLCBWRklPX0NDV19FVkVOVF9OT1RfT1BFUik7Cj4gQEAgLTI3NCw3ICszMjAsOCBA
QCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19zY2hfc2h1dGRvd24oc3RydWN0Cj4gc3ViY2hhbm5lbCAq
c2NoKQo+IMKgICovCj4gwqBzdGF0aWMgaW50IHZmaW9fY2N3X3NjaF9ldmVudChzdHJ1Y3Qgc3Vi
Y2hhbm5lbCAqc2NoLCBpbnQgcHJvY2VzcykKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
dmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0ZSA9IGRldl9nZXRfZHJ2ZGF0YSgmc2NoLQo+ID5kZXYp
Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB2ZmlvX2Njd19wYXJlbnQgKnBhcmVudCA9IGRldl9n
ZXRfZHJ2ZGF0YSgmc2NoLT5kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB2ZmlvX2Njd19w
cml2YXRlICpwcml2YXRlID0gZGV2X2dldF9kcnZkYXRhKCZwYXJlbnQtCj4gPmRldik7Cj4gwqDC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBy
YyA9IC1FQUdBSU47Cj4gwqAKPiBAQCAtMjg3LDggKzMzNCwxMCBAQCBzdGF0aWMgaW50IHZmaW9f
Y2N3X3NjaF9ldmVudChzdHJ1Y3Qgc3ViY2hhbm5lbAo+ICpzY2gsIGludCBwcm9jZXNzKQo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoHJjID0gMDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmIChjaW9f
dXBkYXRlX3NjaGliKHNjaCkpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHZmaW9f
Y2N3X2ZzbV9ldmVudChwcml2YXRlLCBWRklPX0NDV19FVkVOVF9OT1RfT1BFUik7Cj4gK8KgwqDC
oMKgwqDCoMKgaWYgKGNpb191cGRhdGVfc2NoaWIoc2NoKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAocHJpdmF0ZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHZmaW9fY2N3X2ZzbV9ldmVudChwcml2YXRlLAo+IFZGSU9fQ0NX
X0VWRU5UX05PVF9PUEVSKTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoG91dF91bmxvY2s6
Cj4gwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoc2NoLT5sb2NrLCBmbGFn
cyk7Cj4gQEAgLTMyNiw3ICszNzUsOCBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19xdWV1ZV9jcnco
c3RydWN0Cj4gdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0ZSwKPiDCoHN0YXRpYyBpbnQgdmZpb19j
Y3dfY2hwX2V2ZW50KHN0cnVjdCBzdWJjaGFubmVsICpzY2gsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgY2hwX2xpbmsg
KmxpbmssIGludCBldmVudCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3df
cHJpdmF0ZSAqcHJpdmF0ZSA9IGRldl9nZXRfZHJ2ZGF0YSgmc2NoLQo+ID5kZXYpOwo+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCB2ZmlvX2Njd19wYXJlbnQgKnBhcmVudCA9IGRldl9nZXRfZHJ2ZGF0
YSgmc2NoLT5kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB2ZmlvX2Njd19wcml2YXRlICpw
cml2YXRlID0gZGV2X2dldF9kcnZkYXRhKCZwYXJlbnQtCj4gPmRldik7Cj4gwqDCoMKgwqDCoMKg
wqDCoGludCBtYXNrID0gY2hwX3NzZF9nZXRfbWFzaygmc2NoLT5zc2RfaW5mbywgbGluayk7Cj4g
wqDCoMKgwqDCoMKgwqDCoGludCByZXRyeSA9IDI1NTsKPiDCoAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X29wcy5jCj4gYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3
X29wcy5jCj4gaW5kZXggNmFlNGQwMTJkODAwLi5iMWNkODlkOTAwYWIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19vcHMuYwo+ICsrKyBiL2RyaXZlcnMvczM5MC9jaW8v
dmZpb19jY3dfb3BzLmMKPiBAQCAtMTQsNiArMTQsNyBAQAo+IMKgI2luY2x1ZGUgPGxpbnV4L25v
c3BlYy5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiDCoAo+ICsjaW5jbHVkZSAidmZp
b19jY3dfcGFyZW50LmgiCj4gwqAjaW5jbHVkZSAidmZpb19jY3dfcHJpdmF0ZS5oIgo+IMKgCj4g
wqBzdGF0aWMgY29uc3Qgc3RydWN0IHZmaW9fZGV2aWNlX29wcyB2ZmlvX2Njd19kZXZfb3BzOwo+
IEBAIC01NSw3ICs1Niw5IEBAIHN0YXRpYyBpbnQgdmZpb19jY3dfbWRldl9pbml0X2RldihzdHJ1
Y3QKPiB2ZmlvX2RldmljZSAqdmRldikKPiDCoAo+IMKgc3RhdGljIGludCB2ZmlvX2Njd19tZGV2
X3Byb2JlKHN0cnVjdCBtZGV2X2RldmljZSAqbWRldikKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0ZSA9IGRldl9nZXRfZHJ2ZGF0YShtZGV2LQo+
ID5kZXYucGFyZW50KTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc3ViY2hhbm5lbCAqc2NoID0g
dG9fc3ViY2hhbm5lbChtZGV2LT5kZXYucGFyZW50KTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
dmZpb19jY3dfcGFyZW50ICpwYXJlbnQgPSBkZXZfZ2V0X2RydmRhdGEoJnNjaC0+ZGV2KTsKPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0ZSA9IGRldl9nZXRf
ZHJ2ZGF0YSgmcGFyZW50LQo+ID5kZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChwcml2YXRlLT5zdGF0ZSA9PSBWRklPX0NDV19TVEFURV9O
T1RfT1BFUikKPiBAQCAtMTAwLDcgKzEwMyw5IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X21kZXZf
cmVsZWFzZV9kZXYoc3RydWN0Cj4gdmZpb19kZXZpY2UgKnZkZXYpCj4gwqAKPiDCoHN0YXRpYyB2
b2lkIHZmaW9fY2N3X21kZXZfcmVtb3ZlKHN0cnVjdCBtZGV2X2RldmljZSAqbWRldikKPiDCoHsK
PiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAqcHJpdmF0ZSA9IGRldl9n
ZXRfZHJ2ZGF0YShtZGV2LQo+ID5kZXYucGFyZW50KTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
c3ViY2hhbm5lbCAqc2NoID0gdG9fc3ViY2hhbm5lbChtZGV2LT5kZXYucGFyZW50KTsKPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3dfcGFyZW50ICpwYXJlbnQgPSBkZXZfZ2V0X2RydmRh
dGEoJnNjaC0+ZGV2KTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmZpb19jY3dfcHJpdmF0ZSAq
cHJpdmF0ZSA9IGRldl9nZXRfZHJ2ZGF0YSgmcGFyZW50LQo+ID5kZXYpOwo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoFZGSU9fQ0NXX01TR19FVkVOVCgyLCAic2NoICV4LiV4LiUwNHg6IHJlbW92ZVxu
IiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHByaXZhdGUtPnNjaC0+c2NoaWQuY3NzaWQsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9j
aW8vdmZpb19jY3dfcGFyZW50LmgKPiBiL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfcGFyZW50
LmgKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uODM0YzAwMDc3
ODAyCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfcGFy
ZW50LmgKPiBAQCAtMCwwICsxLDI4IEBACj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovCj4gKy8qCj4gKyAqIE1ERVYgUGFyZW50IGNvbnRlbnRzIGZvciB2ZmlvX2NjdyBk
cml2ZXIKPiArICoKPiArICogQ29weXJpZ2h0IElCTSBDb3JwLiAyMDIyCj4gKyAqLwo+ICsKPiAr
I2lmbmRlZiBfVkZJT19DQ1dfUEFSRU5UX0hfCj4gKyNkZWZpbmUgX1ZGSU9fQ0NXX1BBUkVOVF9I
Xwo+ICsKPiArI2luY2x1ZGUgPGxpbnV4L21kZXYuaD4KPiArCj4gKy8qKgo+ICsgKiBzdHJ1Y3Qg
dmZpb19jY3dfcGFyZW50Cj4gKyAqCj4gKyAqIEBkZXY6IGVtYmVkZGVkIGRldmljZSBzdHJ1Y3QK
PiArICogQHBhcmVudDogcGFyZW50IGRhdGEgc3RydWN0dXJlcyBmb3IgbWRldnMgY3JlYXRlZAo+
ICsgKiBAbWRldl90eXBlKHMpOiBpZGVudGlmeWluZyBpbmZvcm1hdGlvbiBmb3IgbWRldnMgY3Jl
YXRlZAo+ICsgKi8KPiArc3RydWN0IHZmaW9fY2N3X3BhcmVudCB7Cj4gK8KgwqDCoMKgwqDCoMKg
c3RydWN0IGRldmljZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXY7Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCBtZGV2X3BhcmVudMKgwqDCoMKgwqDCoHBhcmVudDsKPiArwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgbWRldl90eXBlwqDCoMKgwqDCoMKgwqDCoG1kZXZfdHlwZTsKPiArwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgbWRldl90eXBlwqDCoMKgwqDCoMKgwqDCoCptZGV2X3R5cGVzWzFdOwo+ICt9
Owo+ICsKPiArI2VuZGlmCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3df
cHJpdmF0ZS5oCj4gYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X3ByaXZhdGUuaAo+IGluZGV4
IGJkNWZiODE0NTZhZi4uNjczZTlhODFhMTcyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvczM5MC9j
aW8vdmZpb19jY3dfcHJpdmF0ZS5oCj4gKysrIGIvZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19w
cml2YXRlLmgKPiBAQCAtODksNyArODksNiBAQCBzdHJ1Y3QgdmZpb19jY3dfY3J3IHsKPiDCoCAq
IEBpb193b3JrOiB3b3JrIGZvciBkZWZlcnJhbCBwcm9jZXNzIG9mIEkvTyBoYW5kbGluZwo+IMKg
ICogQGNyd193b3JrOiB3b3JrIGZvciBkZWZlcnJhbCBwcm9jZXNzIG9mIENSVyBoYW5kbGluZwo+
IMKgICogQHJlbGVhc2VfY29tcDogc3luY2hyb25pemF0aW9uIGhlbHBlciBmb3IgdmZpbyBkZXZp
Y2UgcmVsZWFzZQo+IC0gKiBAcGFyZW50OiBwYXJlbnQgZGF0YSBzdHJ1Y3R1cmVzIGZvciBtZGV2
cyBjcmVhdGVkCj4gwqAgKi8KPiDCoHN0cnVjdCB2ZmlvX2Njd19wcml2YXRlIHsKPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHZmaW9fZGV2aWNlIHZkZXY7Cj4gQEAgLTExNiwxMCArMTE1LDYgQEAg
c3RydWN0IHZmaW9fY2N3X3ByaXZhdGUgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgd29ya19z
dHJ1Y3TCoMKgwqDCoMKgwqBjcndfd29yazsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
Y29tcGxldGlvbsKgwqDCoMKgwqDCoMKgcmVsZWFzZV9jb21wOwo+IC0KPiAtwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgbWRldl9wYXJlbnTCoMKgwqDCoMKgwqBwYXJlbnQ7Cj4gLcKgwqDCoMKgwqDCoMKg
c3RydWN0IG1kZXZfdHlwZcKgwqDCoMKgwqDCoMKgwqBtZGV2X3R5cGU7Cj4gLcKgwqDCoMKgwqDC
oMKgc3RydWN0IG1kZXZfdHlwZcKgwqDCoMKgwqDCoMKgwqAqbWRldl90eXBlc1sxXTsKPiDCoH0g
X19hbGlnbmVkKDgpOwo+IMKgCj4gwqBpbnQgdmZpb19jY3dfc2NoX3F1aWVzY2Uoc3RydWN0IHN1
YmNoYW5uZWwgKnNjaCk7Cgo=

