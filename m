Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE217DBD60
	for <lists+linux-s390@lfdr.de>; Mon, 30 Oct 2023 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjJ3QEO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Oct 2023 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjJ3QEL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Oct 2023 12:04:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A7E4;
        Mon, 30 Oct 2023 09:04:09 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UFGMHL028334;
        Mon, 30 Oct 2023 16:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XEFT1vpBsh/Qy1ZUIq/TkJbyFcZcKA0ThT98aOc3XuE=;
 b=T/d/5F6gkayVlvBduzMymTSxmqBgpJnDbahBlDjokP8KaHXQ3/g6hgX+DDqh3F2MT8he
 KK2fyn7IGD9FDD3H6c/h3Skv82MbPVY8emDzwqdRj03IhVRrIzI+oRuu7W5Znd/n1qb5
 AJ9rtQN2IO5jJAI8L1ynjm2PW0XW9o7Rg2UE3sjIfhqrmlkJOqNgBVA310myiSWPxbMd
 FtaoQ2RZJF1TdCsWQbZe3Z0EjUH+Ts7tgkF+53/Ap3SR3AC3LreCTOlHfMZ6HXc1ARp1
 oLJ2FOHGbI27ebOw5G++2dNn0W2fGW4aOjWirY++Y9qPUmMnD6Ltn3LSrz+LAhUIAK+p zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2escsv0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:57 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UFhT9l001944;
        Mon, 30 Oct 2023 16:03:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2escsuy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UEAPir020308;
        Mon, 30 Oct 2023 16:03:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0yac1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UG3q4n1245724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 16:03:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25CAF20040;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E638420043;
        Mon, 30 Oct 2023 16:03:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 16:03:51 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Ricardo Koller <ricarkol@google.com>, kvm@vger.kernel.org,
        Nikos Nikoleris <nikos.nikoleris@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 02/10] s390x: topology: Fix report message
Date:   Mon, 30 Oct 2023 17:03:41 +0100
Message-Id: <20231030160349.458764-3-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030160349.458764-1-nsg@linux.ibm.com>
References: <20231030160349.458764-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 18Y6-OXOR71brAc_3LvS3HjU5UCjqA9U
X-Proofpoint-ORIG-GUID: 9yIoCh-eXovCB7D7oMyD5jlQxtXfFcLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A polarization value of 0 means horizontal polarization.

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 s390x/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/topology.c b/s390x/topology.c
index 6ab8c8d4..1c4a86fe 100644
--- a/s390x/topology.c
+++ b/s390x/topology.c
@@ -277,7 +277,7 @@ static uint8_t *check_tle(void *tc)
 	else
 		report(cpus->pp == POLARIZATION_VERTICAL_HIGH ||
 		       cpus->pp == POLARIZATION_HORIZONTAL,
-		       "Dedicated CPUs are either vertically polarized or have high entitlement");
+		       "Dedicated CPUs are either horizontally polarized or have high entitlement");
 
 	return tc + sizeof(*cpus);
 }
-- 
2.41.0

