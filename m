Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913B57E0065
	for <lists+linux-s390@lfdr.de>; Fri,  3 Nov 2023 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbjKCJaE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Nov 2023 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbjKCJaC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 05:30:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62035D46;
        Fri,  3 Nov 2023 02:30:00 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A39PQlF009746;
        Fri, 3 Nov 2023 09:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kx0Lp6uI+pka6ptrQ0fHpiUFPPoqVxQpUFOpZvaHbcQ=;
 b=b88ObreFlmJ/I4GlDfkQhzY5miYbBpglsPkk9wpchG+YQLlh9Nsa8am/811WOwIcIEMT
 vJeTh/+tZhvSsmdEa2OQQjHQ7zDvn/pKG3epxPJkkKrP1SFZDuDxxflo5r3+YOnAzAH4
 FmefchAba0fL1rrb8MK0ZrTg5aybjiLHnyrxd2kUyRYGRk9vNCgaZXkwQg74sEH7QmK0
 RUtd05dtDoQ/jIBxot957kbIO4CJLz3NER4ItBjmFV88MAoJqoah4mwJXIyP4bHpq0KF
 md4pI+MWphP+Nq7zR0F4XOL9LR8HziIZuV865viUwgrzIwyCqoi9hguNdKBIzso+D1Rp UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4x7703cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:29:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A39RRdn015514;
        Fri, 3 Nov 2023 09:29:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4x7703bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:29:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A37oNYU000614;
        Fri, 3 Nov 2023 09:29:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmtn88h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:29:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A39Tth744958376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 09:29:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C0822004E;
        Fri,  3 Nov 2023 09:29:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A6EF20040;
        Fri,  3 Nov 2023 09:29:55 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 09:29:55 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v7 4/8] s390x: lib: don't forward PSW when handling exception in SIE
Date:   Fri,  3 Nov 2023 10:29:33 +0100
Message-ID: <20231103092954.238491-5-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103092954.238491-1-nrb@linux.ibm.com>
References: <20231103092954.238491-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W7oRrZmo13FsTygyKjSJ_CskNZ8DcrlP
X-Proofpoint-ORIG-GUID: zOhTKTXFnpAaFpbXm_XgvDuKw5bVwTQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_09,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When we're handling a pgm int in SIE, we want to return to the SIE
cleanup after handling the exception. That's why we set pgm_old_psw to
the sie_exit label in fixup_pgm_int.

On nullifing pgm ints, fixup_pgm_int will also forward the old PSW such
that we don't cause an pgm int again.

However, when we want to return to the sie_exit label, this is not
needed (since we've manually set pgm_old_psw). Instead, forwarding the
PSW might cause us to skip an instruction or end up in the middle of an
instruction.

So, let's just skip the rest of the fixup in case we're inside SIE.

Note that we're intentionally not fixing up the PSW in the guest; that's
best left to the test at hand by registering their own psw fixup.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/interrupt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index e0a1713349f6..f33467957dbf 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -145,6 +145,7 @@ static void fixup_pgm_int(struct stack_frame_int *stack)
 	if (lowcore.pgm_old_psw.addr >= (uint64_t)&sie_entry &&
 	    lowcore.pgm_old_psw.addr <= (uint64_t)&sie_exit) {
 		lowcore.pgm_old_psw.addr = (uint64_t)&sie_exit;
+		return;
 	}
 
 	switch (lowcore.pgm_int_code) {
-- 
2.41.0

