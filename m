Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37A5EB6DB
	for <lists+linux-s390@lfdr.de>; Tue, 27 Sep 2022 03:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiI0BbQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 26 Sep 2022 21:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiI0BbP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Sep 2022 21:31:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06ECA4B3E;
        Mon, 26 Sep 2022 18:31:13 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R0mw9R002454;
        Tue, 27 Sep 2022 01:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type :
 content-transfer-encoding : date : mime-version; s=pp1;
 bh=8lysxFcI3vpBcvW11A4jBjEPFol3HoFVCa9QYKKT+Ow=;
 b=CKrkAP05OdvwXF0SIMDkVwe4cz3iL1EoIdgdNw5GRJ8d64b1kwWQatNDMi4Uht0pOkpY
 SVWZxi3fLYD+GXtev7n3jiCHihRefqVNmJGGQFwb6jGX5Qo/8qqXJeO9nODim6rbmayt
 5X3lR4EhuEIhvFYql05h96YArWB4C4PEuOJMTVCH5SFqu51tAMQrXtffLObVx/R8IPgf
 a5T0PZ3hMvkDVRKE9nVjgu+wxdqcjA+zm1740oTvFFxUu9nEvbTvBsKQn45QuEKBW7bN
 P+sewH6GtHhhDvnLLf5ePCJ/ZFsACI9HI1n25+oD9tCMWZxniXtd+oOyKg3uikEZhxHW ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jumefw8x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 01:31:01 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R1UJT6031248;
        Tue, 27 Sep 2022 01:31:00 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jumefw8wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 01:31:00 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R1LH3e015022;
        Tue, 27 Sep 2022 01:30:59 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3jssha5xjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 01:30:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R1UwJA40501670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 01:30:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E62C5804C;
        Tue, 27 Sep 2022 01:30:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E1DD58052;
        Tue, 27 Sep 2022 01:30:56 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.160.170.198])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 01:30:56 +0000 (GMT)
Message-ID: <aaa3966858104ca3828336f743e01e31ac0f29a5.camel@linux.ibm.com>
Subject: Re: [PATCH 11/14] vfio/mdev: consolidate all the name sysfs into
 the core code
From:   Eric Farman <farman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Kevin Tian <kevin.tian@intel.com>
In-Reply-To: <20220923092652.100656-12-hch@lst.de>
References: <20220923092652.100656-1-hch@lst.de>
         <20220923092652.100656-12-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Date:   Mon, 26 Sep 2022 21:28:41 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MxvoYvaCaNaa8sa1Fz3MuF_kCDU9c9WM
X-Proofpoint-GUID: jGmEj1BZ7vNnW3eIDVsAK4mGFXwcGxy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270005
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTIzIGF0IDExOjI2ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBFdmVyeSBkcml2ZXIganVzdCBlbWl0cyBhIHN0YXRpYyBzdHJpbmcsIHNpbXBseSBhZGQg
YSBmaWVsZCB0byB0aGUKPiBtZGV2X3R5cGUgZm9yIHRoZSBkcml2ZXIgdG8gZmlsbCBvdXQgb3Ig
ZmFsbCBiYWNrIHRvIHRoZSBzeXNmcyBuYW1lCj4gYW5kCj4gcHJvdmlkZSBhIHN0YW5kYXJkIHN5
c2ZzIHNob3cgZnVuY3Rpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+Cj4gUmV2aWV3ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5j
b20+Cj4gUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPgo+IFJl
dmlld2VkLWJ5OiBLaXJ0aSBXYW5raGVkZSA8a3dhbmtoZWRlQG52aWRpYS5jb20+CgpSZXZpZXdl
ZC1ieTogRXJpYyBGYXJtYW4gPGZhcm1hbkBsaW51eC5pYm0uY29tPgoKPiAtLS0KPiDCoC4uLi9k
cml2ZXItYXBpL3ZmaW8tbWVkaWF0ZWQtZGV2aWNlLnJzdMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+
IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Z0L2t2bWd0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgOCAtLS0tLS0tCj4gwqBkcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X2Rydi5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gwqBkcml2ZXJzL3MzOTAvY2lvL3Zm
aW9fY2N3X29wcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCAtLS0tLS0tCj4g
wqBkcml2ZXJzL3MzOTAvY3J5cHRvL3ZmaW9fYXBfb3BzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxMCArLS0tLS0tLS0KPiDCoGRyaXZlcnMvdmZpby9tZGV2L21kZXZfc3lzZnMuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwICsrKysrKysrKwo+IMKgaW5jbHVkZS9saW51
eC9tZGV2LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMSArCj4gwqBzYW1wbGVzL3ZmaW8tbWRldi9tYm9jaHMuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjAgKysrKy0tLS0tLS0tLS0tLS0KPiAtCj4gwqBzYW1w
bGVzL3ZmaW8tbWRldi9tZHB5LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMSArKysrKy0tLS0tLS0tLS0tLQo+IC0tCj4gwqBzYW1wbGVzL3ZmaW8tbWRldi9t
dHR5LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysr
LS0tLS0tLS0tLS0tCj4gwqAxMCBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA3MiBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3Zm
aW8tbWVkaWF0ZWQtZGV2aWNlLnJzdAo+IGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZmaW8t
bWVkaWF0ZWQtZGV2aWNlLnJzdAo+IGluZGV4IGIwYzI5ZTM3ZjYxYjQuLmRjZDEyMzFhNmZhODQg
MTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZmaW8tbWVkaWF0ZWQtZGV2
aWNlLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZmlvLW1lZGlhdGVkLWRl
dmljZS5yc3QKPiBAQCAtMjE3LDcgKzIxNyw3IEBAIERpcmVjdG9yaWVzIGFuZCBmaWxlcyB1bmRl
ciB0aGUgc3lzZnMgZm9yIEVhY2gKPiBQaHlzaWNhbCBEZXZpY2UKPiDCoAo+IMKgKiBuYW1lCj4g
wqAKPiAtwqAgVGhpcyBhdHRyaWJ1dGUgc2hvdWxkIHNob3cgaHVtYW4gcmVhZGFibGUgbmFtZS4g
VGhpcyBpcyBvcHRpb25hbAo+IGF0dHJpYnV0ZS4KPiArwqAgVGhpcyBhdHRyaWJ1dGUgc2hvd3Mg
YSBodW1hbiByZWFkYWJsZSBuYW1lLgo+IMKgCj4gwqAqIGRlc2NyaXB0aW9uCj4gwqAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Z0L2t2bWd0LmMKPiBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2d2dC9rdm1ndC5jCj4gaW5kZXggOWIyZDNiMDc4YTJjOS4uMDhmZTc0NThiMzYx
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndnQva3ZtZ3QuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2d2dC9rdm1ndC5jCj4gQEAgLTEzOCwyMCArMTM4LDEyIEBA
IHN0YXRpYyBzc2l6ZV90IGRlc2NyaXB0aW9uX3Nob3coc3RydWN0Cj4gbWRldl90eXBlICptdHlw
ZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlLT5j
b25mLT53ZWlnaHQpOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyBzc2l6ZV90IG5hbWVfc2hvdyhzdHJ1
Y3QgbWRldl90eXBlICptdHlwZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWRldl90eXBlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVm
KQo+IC17Cj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIHNwcmludGYoYnVmLCAiJXNcbiIsIG10eXBl
LT5zeXNmc19uYW1lKTsKPiAtfQo+IC0KPiDCoHN0YXRpYyBNREVWX1RZUEVfQVRUUl9STyhhdmFp
bGFibGVfaW5zdGFuY2VzKTsKPiDCoHN0YXRpYyBNREVWX1RZUEVfQVRUUl9STyhkZXNjcmlwdGlv
bik7Cj4gLXN0YXRpYyBNREVWX1RZUEVfQVRUUl9STyhuYW1lKTsKPiDCoAo+IMKgc3RhdGljIGNv
bnN0IHN0cnVjdCBhdHRyaWJ1dGUgKmd2dF90eXBlX2F0dHJzW10gPSB7Cj4gwqDCoMKgwqDCoMKg
wqDCoCZtZGV2X3R5cGVfYXR0cl9hdmFpbGFibGVfaW5zdGFuY2VzLmF0dHIsCj4gwqDCoMKgwqDC
oMKgwqDCoCZtZGV2X3R5cGVfYXR0cl9kZXNjcmlwdGlvbi5hdHRyLAo+IC3CoMKgwqDCoMKgwqDC
oCZtZGV2X3R5cGVfYXR0cl9uYW1lLmF0dHIsCj4gwqDCoMKgwqDCoMKgwqDCoE5VTEwsCj4gwqB9
Owo+IMKgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfZHJ2LmMKPiBi
L2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfZHJ2LmMKPiBpbmRleCAyNWE1ZGUwOGIzOTAyLi5l
NWYyMWM3MjUzMjZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvczM5MC9jaW8vdmZpb19jY3dfZHJ2
LmMKPiArKysgYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X2Rydi5jCj4gQEAgLTIyMSw2ICsy
MjEsNyBAQCBzdGF0aWMgaW50IHZmaW9fY2N3X3NjaF9wcm9iZShzdHJ1Y3Qgc3ViY2hhbm5lbAo+
ICpzY2gpCj4gwqDCoMKgwqDCoMKgwqDCoGRldl9zZXRfZHJ2ZGF0YSgmc2NoLT5kZXYsIHByaXZh
dGUpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHByaXZhdGUtPm1kZXZfdHlwZS5zeXNmc19uYW1l
ID0gImlvIjsKPiArwqDCoMKgwqDCoMKgwqBwcml2YXRlLT5tZGV2X3R5cGUucHJldHR5X25hbWUg
PSAiSS9PIHN1YmNoYW5uZWwgKE5vbi1RRElPKSI7Cj4gwqDCoMKgwqDCoMKgwqDCoHByaXZhdGUt
Pm1kZXZfdHlwZXNbMF0gPSAmcHJpdmF0ZS0+bWRldl90eXBlOwo+IMKgwqDCoMKgwqDCoMKgwqBy
ZXQgPSBtZGV2X3JlZ2lzdGVyX3BhcmVudCgmcHJpdmF0ZS0+cGFyZW50LCAmc2NoLT5kZXYsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgJnZmaW9fY2N3X21kZXZfZHJpdmVyLAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3MzOTAvY2lvL3ZmaW9fY2N3X29wcy5jCj4gYi9kcml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X29w
cy5jCj4gaW5kZXggNGM3YjE4MTUxOTIyOC4uMzk0YWFiNjBkYmQwYSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3MzOTAvY2lvL3ZmaW9fY2N3X29wcy5jCj4gKysrIGIvZHJpdmVycy9zMzkwL2Npby92
ZmlvX2Njd19vcHMuYwo+IEBAIC00NCwxMyArNDQsNiBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19k
bWFfdW5tYXAoc3RydWN0IHZmaW9fZGV2aWNlCj4gKnZkZXYsIHU2NCBpb3ZhLCB1NjQgbGVuZ3Ro
KQo+IMKgwqDCoMKgwqDCoMKgwqB2ZmlvX2Njd19tZGV2X3Jlc2V0KHByaXZhdGUpOwo+IMKgfQo+
IMKgCj4gLXN0YXRpYyBzc2l6ZV90IG5hbWVfc2hvdyhzdHJ1Y3QgbWRldl90eXBlICptdHlwZSwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
bWRldl90eXBlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+IC17Cj4gLcKgwqDCoMKgwqDC
oMKgcmV0dXJuIHNwcmludGYoYnVmLCAiSS9PIHN1YmNoYW5uZWwgKE5vbi1RRElPKVxuIik7Cj4g
LX0KPiAtc3RhdGljIE1ERVZfVFlQRV9BVFRSX1JPKG5hbWUpOwo+IC0KPiDCoHN0YXRpYyBzc2l6
ZV90IGF2YWlsYWJsZV9pbnN0YW5jZXNfc2hvdyhzdHJ1Y3QgbWRldl90eXBlICptdHlwZSwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBtZGV2X3R5cGVfYXR0cmlidXRlCj4gKmF0dHIs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaGFyICpidWYpCj4gQEAgLTYyLDcgKzU1LDYgQEAg
c3RhdGljIHNzaXplX3QgYXZhaWxhYmxlX2luc3RhbmNlc19zaG93KHN0cnVjdAo+IG1kZXZfdHlw
ZSAqbXR5cGUsCj4gwqBzdGF0aWMgTURFVl9UWVBFX0FUVFJfUk8oYXZhaWxhYmxlX2luc3RhbmNl
cyk7Cj4gwqAKPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlICptZGV2X3R5cGVzX2F0
dHJzW10gPSB7Cj4gLcKgwqDCoMKgwqDCoMKgJm1kZXZfdHlwZV9hdHRyX25hbWUuYXR0ciwKPiDC
oMKgwqDCoMKgwqDCoMKgJm1kZXZfdHlwZV9hdHRyX2F2YWlsYWJsZV9pbnN0YW5jZXMuYXR0ciwK
PiDCoMKgwqDCoMKgwqDCoMKgTlVMTCwKPiDCoH07Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5
MC9jcnlwdG8vdmZpb19hcF9vcHMuYwo+IGIvZHJpdmVycy9zMzkwL2NyeXB0by92ZmlvX2FwX29w
cy5jCj4gaW5kZXggZDQ0MGFjZmJiMjYxZS4uNWQ4ZGQ3ZTgzN2YzZCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3MzOTAvY3J5cHRvL3ZmaW9fYXBfb3BzLmMKPiArKysgYi9kcml2ZXJzL3MzOTAvY3J5
cHRvL3ZmaW9fYXBfb3BzLmMKPiBAQCAtNzkwLDE0ICs3OTAsNiBAQCBzdGF0aWMgdm9pZCB2Zmlv
X2FwX21kZXZfcmVtb3ZlKHN0cnVjdAo+IG1kZXZfZGV2aWNlICptZGV2KQo+IMKgwqDCoMKgwqDC
oMKgwqB2ZmlvX3B1dF9kZXZpY2UoJm1hdHJpeF9tZGV2LT52ZGV2KTsKPiDCoH0KPiDCoAo+IC1z
dGF0aWMgc3NpemVfdCBuYW1lX3Nob3coc3RydWN0IG1kZXZfdHlwZSAqbXR5cGUsCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1kZXZfdHlw
ZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKPiAtewo+IC3CoMKgwqDCoMKgwqDCoHJldHVy
biBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCBWRklPX0FQX01ERVZfTkFNRV9IV1ZJUlQpOwo+IC19Cj4g
LQo+IC1zdGF0aWMgTURFVl9UWVBFX0FUVFJfUk8obmFtZSk7Cj4gLQo+IMKgc3RhdGljIHNzaXpl
X3QgYXZhaWxhYmxlX2luc3RhbmNlc19zaG93KHN0cnVjdCBtZGV2X3R5cGUgKm10eXBlLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1kZXZfdHlwZV9hdHRyaWJ1dGUKPiAqYXR0ciwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoYXIgKmJ1ZikKPiBAQCAtODA5LDcgKzgwMSw2IEBA
IHN0YXRpYyBzc2l6ZV90IGF2YWlsYWJsZV9pbnN0YW5jZXNfc2hvdyhzdHJ1Y3QKPiBtZGV2X3R5
cGUgKm10eXBlLAo+IMKgc3RhdGljIE1ERVZfVFlQRV9BVFRSX1JPKGF2YWlsYWJsZV9pbnN0YW5j
ZXMpOwo+IMKgCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqdmZpb19hcF9tZGV2
X3R5cGVfYXR0cnNbXSA9IHsKPiAtwqDCoMKgwqDCoMKgwqAmbWRldl90eXBlX2F0dHJfbmFtZS5h
dHRyLAo+IMKgwqDCoMKgwqDCoMKgwqAmbWRldl90eXBlX2F0dHJfYXZhaWxhYmxlX2luc3RhbmNl
cy5hdHRyLAo+IMKgwqDCoMKgwqDCoMKgwqBOVUxMLAo+IMKgfTsKPiBAQCAtMTgxMyw2ICsxODA0
LDcgQEAgaW50IHZmaW9fYXBfbWRldl9yZWdpc3Rlcih2b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBtYXRyaXhf
ZGV2LT5tZGV2X3R5cGUuc3lzZnNfbmFtZSA9IFZGSU9fQVBfTURFVl9UWVBFX0hXVklSVDsKPiAr
wqDCoMKgwqDCoMKgwqBtYXRyaXhfZGV2LT5tZGV2X3R5cGUucHJldHR5X25hbWUgPSBWRklPX0FQ
X01ERVZfTkFNRV9IV1ZJUlQ7Cj4gwqDCoMKgwqDCoMKgwqDCoG1hdHJpeF9kZXYtPm1kZXZfdHlw
ZXNbMF0gPSAmbWF0cml4X2Rldi0+bWRldl90eXBlOwo+IMKgwqDCoMKgwqDCoMKgwqByZXQgPSBt
ZGV2X3JlZ2lzdGVyX3BhcmVudCgmbWF0cml4X2Rldi0+cGFyZW50LCAmbWF0cml4X2Rldi0KPiA+
ZGV2aWNlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ2ZmlvX2FwX21hdHJpeF9kcml2ZXIsCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmZpby9tZGV2L21kZXZfc3lzZnMuYwo+IGIvZHJpdmVycy92ZmlvL21kZXYv
bWRldl9zeXNmcy5jCj4gaW5kZXggNjBmYzUyZmY5MjQ0OC4uMzQ1ODNlNmE5N2YyNyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZmaW8vbWRldi9tZGV2X3N5c2ZzLmMKPiArKysgYi9kcml2ZXJzL3Zm
aW8vbWRldi9tZGV2X3N5c2ZzLmMKPiBAQCAtODEsOSArODEsMTkgQEAgc3RhdGljIHNzaXplX3Qg
ZGV2aWNlX2FwaV9zaG93KHN0cnVjdCBtZGV2X3R5cGUKPiAqbXR5cGUsCj4gwqB9Cj4gwqBzdGF0
aWMgTURFVl9UWVBFX0FUVFJfUk8oZGV2aWNlX2FwaSk7Cj4gwqAKPiArc3RhdGljIHNzaXplX3Qg
bmFtZV9zaG93KHN0cnVjdCBtZGV2X3R5cGUgKm10eXBlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtZGV2X3R5cGVfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3ByaW50ZihidWYs
ICIlc1xuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXR5cGUtPnByZXR0eV9u
YW1lID8gbXR5cGUtPnByZXR0eV9uYW1lIDogbXR5cGUtCj4gPnN5c2ZzX25hbWUpOwo+ICt9Cj4g
Kwo+ICtzdGF0aWMgTURFVl9UWVBFX0FUVFJfUk8obmFtZSk7Cj4gKwo+IMKgc3RhdGljIHN0cnVj
dCBhdHRyaWJ1dGUgKm1kZXZfdHlwZXNfY29yZV9hdHRyc1tdID0gewo+IMKgwqDCoMKgwqDCoMKg
wqAmbWRldl90eXBlX2F0dHJfY3JlYXRlLmF0dHIsCj4gwqDCoMKgwqDCoMKgwqDCoCZtZGV2X3R5
cGVfYXR0cl9kZXZpY2VfYXBpLmF0dHIsCj4gK8KgwqDCoMKgwqDCoMKgJm1kZXZfdHlwZV9hdHRy
X25hbWUuYXR0ciwKPiDCoMKgwqDCoMKgwqDCoMKgTlVMTCwKPiDCoH07Cj4gwqAKPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9tZGV2LmggYi9pbmNsdWRlL2xpbnV4L21kZXYuaAo+IGluZGV4
IGFmMWZmMDE2NWI4ZDMuLjRiYjhhNThiNTc3YjMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC9tZGV2LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L21kZXYuaAo+IEBAIC0yNiw2ICsyNiw3IEBA
IHN0cnVjdCBtZGV2X2RldmljZSB7Cj4gwqBzdHJ1Y3QgbWRldl90eXBlIHsKPiDCoMKgwqDCoMKg
wqDCoMKgLyogc2V0IGJ5IHRoZSBkcml2ZXIgYmVmb3JlIGNhbGxpbmcgbWRldl9yZWdpc3RlciBw
YXJlbnQ6ICovCj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKnN5c2ZzX25hbWU7Cj4gK8Kg
wqDCoMKgwqDCoMKgY29uc3QgY2hhciAqcHJldHR5X25hbWU7Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgLyogc2V0IGJ5IHRoZSBjb3JlLCBjYW4gYmUgdXNlZCBkcml2ZXJzICovCj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBtZGV2X3BhcmVudCAqcGFyZW50Owo+IGRpZmYgLS1naXQgYS9zYW1wbGVz
L3ZmaW8tbWRldi9tYm9jaHMuYyBiL3NhbXBsZXMvdmZpby1tZGV2L21ib2Nocy5jCj4gaW5kZXgg
YTJmYzEzZmFkZTc1Ny4uMGI3NTg1ZjE2ZDhhYiAxMDA2NDQKPiAtLS0gYS9zYW1wbGVzL3ZmaW8t
bWRldi9tYm9jaHMuYwo+ICsrKyBiL3NhbXBsZXMvdmZpby1tZGV2L21ib2Nocy5jCj4gQEAgLTEw
MSwyNiArMTAxLDI1IEBAIE1PRFVMRV9QQVJNX0RFU0MobWVtLCAibWVnYWJ5dGVzIGF2YWlsYWJs
ZSB0byAiCj4gTUJPQ0hTX05BTUUgIiBkZXZpY2VzIik7Cj4gwqAKPiDCoHN0YXRpYyBzdHJ1Y3Qg
bWJvY2hzX3R5cGUgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWRldl90eXBlIHR5cGU7Cj4g
LcKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqbmFtZTsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIG1i
eXRlczsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIG1heF94Owo+IMKgwqDCoMKgwqDCoMKgwqB1MzIg
bWF4X3k7Cj4gwqB9IG1ib2Noc190eXBlc1tdID0gewo+IMKgwqDCoMKgwqDCoMKgwqB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudHlwZS5zeXNmc19uYW1lwqDCoMKgwqDCoMKg
wqDCoD0gTUJPQ0hTX1RZUEVfMSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5h
bWXCoMKgwqA9IE1CT0NIU19DTEFTU19OQU1FICItIiBNQk9DSFNfVFlQRV8xLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudHlwZS5wcmV0dHlfbmFtZcKgwqDCoMKgwqDCoMKgPSBN
Qk9DSFNfQ0xBU1NfTkFNRSAiLSIKPiBNQk9DSFNfVFlQRV8xLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLm1ieXRlcyA9IDQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAubWF4X3jCoCA9IDgwMCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5t
YXhfecKgID0gNjAwLAo+IMKgwqDCoMKgwqDCoMKgwqB9LCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAudHlwZS5zeXNmc19uYW1lwqDCoMKgwqDCoMKgwqDCoD0gTUJPQ0hTX1RZ
UEVfMiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWXCoMKgwqA9IE1CT0NI
U19DTEFTU19OQU1FICItIiBNQk9DSFNfVFlQRV8yLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAudHlwZS5wcmV0dHlfbmFtZcKgwqDCoMKgwqDCoMKgPSBNQk9DSFNfQ0xBU1NfTkFN
RSAiLSIKPiBNQk9DSFNfVFlQRV8yLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Lm1ieXRlcyA9IDE2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF94wqAg
PSAxOTIwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF95wqAgPSAxNDQw
LAo+IMKgwqDCoMKgwqDCoMKgwqB9LCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAudHlwZS5zeXNmc19uYW1lwqDCoMKgwqDCoMKgwqDCoD0gTUJPQ0hTX1RZUEVfMywKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWXCoMKgwqA9IE1CT0NIU19DTEFTU19OQU1F
ICItIiBNQk9DSFNfVFlQRV8zLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudHlw
ZS5wcmV0dHlfbmFtZcKgwqDCoMKgwqDCoMKgPSBNQk9DSFNfQ0xBU1NfTkFNRSAiLSIKPiBNQk9D
SFNfVFlQRV8zLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1ieXRlcyA9IDY0
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF94wqAgPSAwLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1heF95wqAgPSAwLAo+IEBAIC01NTYsNyArNTU1
LDcgQEAgc3RhdGljIGludCBtYm9jaHNfaW5pdF9kZXYoc3RydWN0IHZmaW9fZGV2aWNlCj4gKnZk
ZXYpCj4gwqDCoMKgwqDCoMKgwqDCoG1ib2Noc19yZXNldChtZGV2X3N0YXRlKTsKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqBkZXZfaW5mbyh2ZGV2LT5kZXYsICIlczogJXMsICVkIE1CLCAlbGQgcGFn
ZXNcbiIsIF9fZnVuY19fLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHlwZS0+
bmFtZSwgdHlwZS0+bWJ5dGVzLCBtZGV2X3N0YXRlLT5wYWdlY291bnQpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdHlwZS0+dHlwZS5wcmV0dHlfbmFtZSwgdHlwZS0+bWJ5dGVz
LCBtZGV2X3N0YXRlLQo+ID5wYWdlY291bnQpOwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsK
PiDCoAo+IMKgZXJyX3Zjb25maWc6Cj4gQEAgLTEzNTEsMTYgKzEzNTAsNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cAo+ICptZGV2X2Rldl9ncm91cHNbXSA9IHsKPiDCoMKg
wqDCoMKgwqDCoMKgTlVMTCwKPiDCoH07Cj4gwqAKPiAtc3RhdGljIHNzaXplX3QgbmFtZV9zaG93
KHN0cnVjdCBtZGV2X3R5cGUgKm10eXBlLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtZGV2X3R5cGVfYXR0cmlidXRlICphdHRyLCBjaGFy
ICpidWYpCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWJvY2hzX3R5cGUgKnR5cGUgPQo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250YWluZXJfb2YobXR5cGUsIHN0cnVj
dCBtYm9jaHNfdHlwZSwgdHlwZSk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBzcHJpbnRm
KGJ1ZiwgIiVzXG4iLCB0eXBlLT5uYW1lKTsKPiAtfQo+IC1zdGF0aWMgTURFVl9UWVBFX0FUVFJf
Uk8obmFtZSk7Cj4gLQo+IMKgc3RhdGljIHNzaXplX3QgZGVzY3JpcHRpb25fc2hvdyhzdHJ1Y3Qg
bWRldl90eXBlICptdHlwZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1kZXZfdHlwZV9hdHRyaWJ1dGUgKmF0
dHIsCj4gY2hhciAqYnVmKQo+IMKgewo+IEBAIC0xMzg1LDcgKzEzNzQsNiBAQCBzdGF0aWMgc3Np
emVfdCBhdmFpbGFibGVfaW5zdGFuY2VzX3Nob3coc3RydWN0Cj4gbWRldl90eXBlICptdHlwZSwK
PiDCoHN0YXRpYyBNREVWX1RZUEVfQVRUUl9STyhhdmFpbGFibGVfaW5zdGFuY2VzKTsKPiDCoAo+
IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGUgKm1kZXZfdHlwZXNfYXR0cnNbXSA9IHsK
PiAtwqDCoMKgwqDCoMKgwqAmbWRldl90eXBlX2F0dHJfbmFtZS5hdHRyLAo+IMKgwqDCoMKgwqDC
oMKgwqAmbWRldl90eXBlX2F0dHJfZGVzY3JpcHRpb24uYXR0ciwKPiDCoMKgwqDCoMKgwqDCoMKg
Jm1kZXZfdHlwZV9hdHRyX2F2YWlsYWJsZV9pbnN0YW5jZXMuYXR0ciwKPiDCoMKgwqDCoMKgwqDC
oMKgTlVMTCwKPiBkaWZmIC0tZ2l0IGEvc2FtcGxlcy92ZmlvLW1kZXYvbWRweS5jIGIvc2FtcGxl
cy92ZmlvLW1kZXYvbWRweS5jCj4gaW5kZXggZjkwNjllZDI3NTBmYS4uOTBjNmZlZDIwMGIxOSAx
MDA2NDQKPiAtLS0gYS9zYW1wbGVzL3ZmaW8tbWRldi9tZHB5LmMKPiArKysgYi9zYW1wbGVzL3Zm
aW8tbWRldi9tZHB5LmMKPiBAQCAtNTMsNyArNTMsNiBAQCBNT0RVTEVfUEFSTV9ERVNDKGNvdW50
LCAibnVtYmVyIG9mICIgTURQWV9OQU1FICIKPiBkZXZpY2VzIik7Cj4gwqAKPiDCoHN0YXRpYyBz
dHJ1Y3QgbWRweV90eXBlIHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1kZXZfdHlwZSB0eXBl
Owo+IC3CoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKm5hbWU7Cj4gwqDCoMKgwqDCoMKgwqDCoHUz
MiBmb3JtYXQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHUzMiBieXRlcHA7Cj4gwqDCoMKgwqDCoMKgwqDC
oHUzMiB3aWR0aDsKPiBAQCAtNjEsMjEgKzYwLDIxIEBAIHN0YXRpYyBzdHJ1Y3QgbWRweV90eXBl
IHsKPiDCoH0gbWRweV90eXBlc1tdID0gewo+IMKgwqDCoMKgwqDCoMKgwqB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudHlwZS5zeXNmc19uYW1lwqDCoMKgwqDCoMKgwqDCoD0g
TURQWV9UWVBFXzEsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5uYW1lwqDCoMKg
PSBNRFBZX0NMQVNTX05BTUUgIi0iIE1EUFlfVFlQRV8xLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAudHlwZS5wcmV0dHlfbmFtZcKgwqDCoMKgwqDCoMKgPSBNRFBZX0NMQVNTX05B
TUUgIi0iCj4gTURQWV9UWVBFXzEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
Zm9ybWF0ID0gRFJNX0ZPUk1BVF9YUkdCODg4OCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5ieXRlcHAgPSA0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLndp
ZHRowqDCoD0gNjQwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmhlaWdodCA9
IDQ4MCwKPiDCoMKgwqDCoMKgwqDCoMKgfSwgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLnR5cGUuc3lzZnNfbmFtZcKgwqDCoMKgwqDCoMKgwqA9IE1EUFlfVFlQRV8yLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmFtZcKgwqDCoD0gTURQWV9DTEFTU19OQU1F
ICItIiBNRFBZX1RZUEVfMiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnR5cGUu
cHJldHR5X25hbWXCoMKgwqDCoMKgwqDCoD0gTURQWV9DTEFTU19OQU1FICItIgo+IE1EUFlfVFlQ
RV8yLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZvcm1hdCA9IERSTV9GT1JN
QVRfWFJHQjg4ODgsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYnl0ZXBwID0g
NCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC53aWR0aMKgwqA9IDEwMjQsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuaGVpZ2h0ID0gNzY4LAo+IMKgwqDCoMKg
wqDCoMKgwqB9LCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudHlwZS5zeXNm
c19uYW1lwqDCoMKgwqDCoMKgwqDCoD0gTURQWV9UWVBFXzMsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5uYW1lwqDCoMKgPSBNRFBZX0NMQVNTX05BTUUgIi0iIE1EUFlfVFlQRV8z
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudHlwZS5wcmV0dHlfbmFtZcKgwqDC
oMKgwqDCoMKgPSBNRFBZX0NMQVNTX05BTUUgIi0iCj4gTURQWV9UWVBFXzMsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZm9ybWF0ID0gRFJNX0ZPUk1BVF9YUkdCODg4OCwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5ieXRlcHAgPSA0LAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLndpZHRowqDCoD0gMTkyMCwKPiBAQCAtMjU2LDggKzI1NSw4
IEBAIHN0YXRpYyBpbnQgbWRweV9pbml0X2RldihzdHJ1Y3QgdmZpb19kZXZpY2UKPiAqdmRldikK
PiDCoMKgwqDCoMKgwqDCoMKgbWRweV9jcmVhdGVfY29uZmlnX3NwYWNlKG1kZXZfc3RhdGUpOwo+
IMKgwqDCoMKgwqDCoMKgwqBtZHB5X3Jlc2V0KG1kZXZfc3RhdGUpOwo+IMKgCj4gLcKgwqDCoMKg
wqDCoMKgZGV2X2luZm8odmRldi0+ZGV2LCAiJXM6ICVzICglZHglZClcbiIsIF9fZnVuY19fLCB0
eXBlLT5uYW1lLAo+IHR5cGUtPndpZHRoLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdHlwZS0+aGVpZ2h0KTsKPiArwqDCoMKgwqDCoMKgwqBkZXZfaW5mbyh2ZGV2LT5kZXYsICIl
czogJXMgKCVkeCVkKVxuIiwgX19mdW5jX18sIHR5cGUtCj4gPnR5cGUucHJldHR5X25hbWUsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlLT53aWR0aCwgdHlwZS0+aGVpZ2h0
KTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBtZHB5X2NvdW50Kys7Cj4gwqDCoMKgwqDCoMKgwqDC
oHJldHVybiAwOwo+IEBAIC02NjIsMTUgKzY2MSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0
cmlidXRlX2dyb3VwCj4gKm1kZXZfZGV2X2dyb3Vwc1tdID0gewo+IMKgwqDCoMKgwqDCoMKgwqBO
VUxMLAo+IMKgfTsKPiDCoAo+IC1zdGF0aWMgc3NpemVfdCBuYW1lX3Nob3coc3RydWN0IG1kZXZf
dHlwZSAqbXR5cGUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IG1kZXZfdHlwZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKPiAtewo+
IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBtZHB5X3R5cGUgKnR5cGUgPSBjb250YWluZXJfb2YobXR5
cGUsIHN0cnVjdAo+IG1kcHlfdHlwZSwgdHlwZSk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJldHVy
biBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCB0eXBlLT5uYW1lKTsKPiAtfQo+IC1zdGF0aWMgTURFVl9U
WVBFX0FUVFJfUk8obmFtZSk7Cj4gLQo+IMKgc3RhdGljIHNzaXplX3QgZGVzY3JpcHRpb25fc2hv
dyhzdHJ1Y3QgbWRldl90eXBlICptdHlwZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1kZXZfdHlwZV9hdHRy
aWJ1dGUgKmF0dHIsCj4gY2hhciAqYnVmKQo+IMKgewo+IEBAIC02OTAsNyArNjgwLDYgQEAgc3Rh
dGljIHNzaXplX3QgYXZhaWxhYmxlX2luc3RhbmNlc19zaG93KHN0cnVjdAo+IG1kZXZfdHlwZSAq
bXR5cGUsCj4gwqBzdGF0aWMgTURFVl9UWVBFX0FUVFJfUk8oYXZhaWxhYmxlX2luc3RhbmNlcyk7
Cj4gwqAKPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlICptZGV2X3R5cGVzX2F0dHJz
W10gPSB7Cj4gLcKgwqDCoMKgwqDCoMKgJm1kZXZfdHlwZV9hdHRyX25hbWUuYXR0ciwKPiDCoMKg
wqDCoMKgwqDCoMKgJm1kZXZfdHlwZV9hdHRyX2Rlc2NyaXB0aW9uLmF0dHIsCj4gwqDCoMKgwqDC
oMKgwqDCoCZtZGV2X3R5cGVfYXR0cl9hdmFpbGFibGVfaW5zdGFuY2VzLmF0dHIsCj4gwqDCoMKg
wqDCoMKgwqDCoE5VTEwsCj4gZGlmZiAtLWdpdCBhL3NhbXBsZXMvdmZpby1tZGV2L210dHkuYyBi
L3NhbXBsZXMvdmZpby1tZGV2L210dHkuYwo+IGluZGV4IDA2NGU3MWIyOGRkMTkuLmVhYjFiNDQ0
MmE5NmUgMTAwNjQ0Cj4gLS0tIGEvc2FtcGxlcy92ZmlvLW1kZXYvbXR0eS5jCj4gKysrIGIvc2Ft
cGxlcy92ZmlvLW1kZXYvbXR0eS5jCj4gQEAgLTE0NiwxMCArMTQ2LDExIEBAIHN0cnVjdCBtZGV2
X3N0YXRlIHsKPiDCoHN0YXRpYyBzdHJ1Y3QgbXR0eV90eXBlIHsKPiDCoMKgwqDCoMKgwqDCoMKg
c3RydWN0IG1kZXZfdHlwZSB0eXBlOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgbnJfcG9ydHM7Cj4g
LcKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqbmFtZTsKPiDCoH0gbXR0eV90eXBlc1syXSA9IHsK
PiAtwqDCoMKgwqDCoMKgwqB7IC5ucl9wb3J0cyA9IDEsIC50eXBlLnN5c2ZzX25hbWUgPSAiMSIs
IC5uYW1lID0gIlNpbmdsZSBwb3J0Cj4gc2VyaWFsIiB9LAo+IC3CoMKgwqDCoMKgwqDCoHsgLm5y
X3BvcnRzID0gMiwgLnR5cGUuc3lzZnNfbmFtZSA9ICIyIiwgLm5hbWUgPSAiRHVhbCBwb3J0Cj4g
c2VyaWFsIiB9LAo+ICvCoMKgwqDCoMKgwqDCoHsgLm5yX3BvcnRzID0gMSwgLnR5cGUuc3lzZnNf
bmFtZSA9ICIxIiwKPiArwqDCoMKgwqDCoMKgwqDCoCAudHlwZS5wcmV0dHlfbmFtZSA9ICJTaW5n
bGUgcG9ydCBzZXJpYWwiIH0sCj4gK8KgwqDCoMKgwqDCoMKgeyAubnJfcG9ydHMgPSAyLCAudHlw
ZS5zeXNmc19uYW1lID0gIjIiLAo+ICvCoMKgwqDCoMKgwqDCoMKgIC50eXBlLnByZXR0eV9uYW1l
ID0gIkR1YWwgcG9ydCBzZXJpYWwiIH0sCj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgc3RydWN0IG1k
ZXZfdHlwZSAqbXR0eV9tZGV2X3R5cGVzW10gPSB7Cj4gQEAgLTEyNTUsMTYgKzEyNTYsNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cAo+ICptZGV2X2Rldl9ncm91cHNbXSA9
IHsKPiDCoMKgwqDCoMKgwqDCoMKgTlVMTCwKPiDCoH07Cj4gwqAKPiAtc3RhdGljIHNzaXplX3Qg
bmFtZV9zaG93KHN0cnVjdCBtZGV2X3R5cGUgKm10eXBlLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtZGV2X3R5cGVfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbXR0eV90eXBlICp0
eXBlID0gY29udGFpbmVyX29mKG10eXBlLCBzdHJ1Y3QKPiBtdHR5X3R5cGUsIHR5cGUpOwo+IC0K
PiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwgdHlwZS0+bmFt
ZSk7Cj4gLX0KPiAtCj4gLXN0YXRpYyBNREVWX1RZUEVfQVRUUl9STyhuYW1lKTsKPiAtCj4gwqBz
dGF0aWMgc3NpemVfdCBhdmFpbGFibGVfaW5zdGFuY2VzX3Nob3coc3RydWN0IG1kZXZfdHlwZSAq
bXR5cGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbWRldl90eXBlX2F0dHJpYnV0
ZQo+ICphdHRyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hhciAqYnVmKQo+IEBAIC0xMjc4
LDcgKzEyNjksNiBAQCBzdGF0aWMgc3NpemVfdCBhdmFpbGFibGVfaW5zdGFuY2VzX3Nob3coc3Ry
dWN0Cj4gbWRldl90eXBlICptdHlwZSwKPiDCoHN0YXRpYyBNREVWX1RZUEVfQVRUUl9STyhhdmFp
bGFibGVfaW5zdGFuY2VzKTsKPiDCoAo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGUg
Km1kZXZfdHlwZXNfYXR0cnNbXSA9IHsKPiAtwqDCoMKgwqDCoMKgwqAmbWRldl90eXBlX2F0dHJf
bmFtZS5hdHRyLAo+IMKgwqDCoMKgwqDCoMKgwqAmbWRldl90eXBlX2F0dHJfYXZhaWxhYmxlX2lu
c3RhbmNlcy5hdHRyLAo+IMKgwqDCoMKgwqDCoMKgwqBOVUxMLAo+IMKgfTsKCg==

