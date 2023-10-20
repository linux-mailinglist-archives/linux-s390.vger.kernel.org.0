Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8007D121C
	for <lists+linux-s390@lfdr.de>; Fri, 20 Oct 2023 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377588AbjJTPDJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Oct 2023 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377616AbjJTPDI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Oct 2023 11:03:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF8A3;
        Fri, 20 Oct 2023 08:03:06 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KF1LKd026901;
        Fri, 20 Oct 2023 15:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vfy2BbXPZ3GBSfZP8lhNLksdq2mP+G/GRk1P80/4JL8=;
 b=PF8LwiS3wjQBZC/8SK7gVJ/0gd/zgs6NORfBPVYzDSxC7xw8C6/CWGL8hU4Cm0mkGZRm
 uF0MABs8TOq4oV3JwljGzfZ7DmSRWWEqmDVP4dPaN6rkk9zixjvXfqnATqUiLu37LSxf
 CYItyqWgi3Sd3/Sv112dViav7cjVsQh5yE0pNIwzyaktHY8mUMu5815pHqgqvWyx8sXz
 DIf1hlZBoSMYUrXyqQJRf3leEsDW+PTACgLHW+e9sV/nkk0sSSeqMxJj/PoLASY5JMjs
 wiI+QABz7lyjI4e3X0e8ZriMOw/lGDIgu1JJnKTxtw97YGj917ASCIhhNvSh8wDwggaZ hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuupp8b81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:02:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39KF2Kkq001575;
        Fri, 20 Oct 2023 15:02:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuupp8b1a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:02:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KC0UiJ032066;
        Fri, 20 Oct 2023 14:49:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc35n6h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 14:49:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KEn73s16908946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 14:49:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B2D120040;
        Fri, 20 Oct 2023 14:49:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEAC420043;
        Fri, 20 Oct 2023 14:49:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Oct 2023 14:49:06 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>,
        Nikos Nikoleris <nikos.nikoleris@arm.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Shaoqin Huang <shahuang@redhat.com>,
        linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Subject: [kvm-unit-tests PATCH 10/10] s390x: topology: Add complex topology test
Date:   Fri, 20 Oct 2023 16:49:00 +0200
Message-Id: <20231020144900.2213398-11-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020144900.2213398-1-nsg@linux.ibm.com>
References: <20231020144900.2213398-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WwuMV6V4Vs3NfekM9balOy-TckyosR2W
X-Proofpoint-GUID: _wqwSnBb2f8qB71n3DQZlq_yRVMPMRBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Run the topology test case with a complex topology configuration.
Randomly generated with:
python -c 'import random
ds=bs=ss=2
cs=16
cids=list(range(1,ds*bs*ss*cs))
random.shuffle(cids)
i = 0
for d in range(ds):
    for b in range(bs):
        for s in range(ss):
            for c in range(cs):
                if (d,b,s,c) != (0,0,0,0):
                    ded=["false","true"][random.randrange(0,2)]
                    ent="high" if ded == "true" else ["low", "medium", "high"][random.randrange(0,3)]
                    print(f"-device max-s390x-cpu,core-id={cids[i]},drawer-id={d},book-id={b},socket-id={s},entitlement={ent},dedicated={ded}")
                    i+=1'

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 s390x/unittests.cfg | 133 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 68e119e4..b08b0fb1 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -247,3 +247,136 @@ file = topology.elf
 [topology-2]
 file = topology.elf
 extra_params = -cpu max,ctop=on -smp sockets=31,cores=8,maxcpus=248  -append '-sockets 31 -cores 8'
+
+[topology-3]
+file = topology.elf
+extra_params = """-cpu max,ctop=on -smp cpus=1,drawers=2,books=2,sockets=2,cores=16,maxcpus=128 \
+-append '-drawers 2 -books 2 -sockets 2 -cores 16' \
+-device max-s390x-cpu,core-id=31,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=11,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=95,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=73,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=78,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=13,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=40,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=101,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=29,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=56,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=92,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=30,drawer-id=0,book-id=0,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=118,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=71,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=93,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=16,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=5,drawer-id=0,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=42,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=98,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=44,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=23,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=65,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=102,drawer-id=0,book-id=0,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=57,drawer-id=0,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=125,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=127,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=82,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=14,drawer-id=0,book-id=0,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=91,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=12,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=8,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=112,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=109,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=19,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=96,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=67,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=80,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=108,drawer-id=0,book-id=1,socket-id=0,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=34,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=18,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=39,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=53,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=46,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=3,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=76,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=15,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=7,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=81,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=1,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=113,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=38,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=90,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=117,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=62,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=85,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=49,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=24,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=107,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=103,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=33,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=51,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=21,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=72,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=63,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=105,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=74,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=50,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=60,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=22,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=43,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=48,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=35,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=58,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=106,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=123,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=122,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=9,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=10,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=25,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=116,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=26,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=17,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=20,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=59,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=54,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=70,drawer-id=1,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=88,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=6,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=52,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=55,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=124,drawer-id=1,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=61,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=84,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=68,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=86,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=4,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=75,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=115,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=28,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=120,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=41,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=87,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=119,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=114,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=104,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=27,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=121,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=126,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=37,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=32,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=94,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=110,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=77,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=36,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=66,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=83,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=47,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=99,drawer-id=1,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=79,drawer-id=1,book-id=1,socket-id=1,entitlement=low,dedicated=false \
+-device max-s390x-cpu,core-id=100,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+-device max-s390x-cpu,core-id=89,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=false \
+-device max-s390x-cpu,core-id=2,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=45,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=69,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=64,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=97,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
+-device max-s390x-cpu,core-id=111,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
+"""
-- 
2.41.0

