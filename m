Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15A2AD292
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 10:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKJJgb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgKJJgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9WXcj109777
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=gDQiXH2OfN2/O9LtvKv/7bC6b8rk+3Lgo9hmp1y3YrU=;
 b=R0pYq9T1+vDMPF0TIxvm1qrVrz7Png6sr5QIYraLKIYJGeetsZv0D5bAKmk6C6u1Ankh
 NcxANU4PLgE23wzgzkLL6NnxzhSArfm779ELkGPTr1rssC38WO2PhNggiftYGJwIAkfK
 xHKJKxlvQ74MXXZCmZDdPuE3Oy2Ka2Rxi6O2bHbn7QoQWUSblxPHXFl0aOVQfTWGm6YN
 H+qFWg0LHkX+fMhHT5f1W9d/HJ2bzoC8yZ6xUINxZgUiP1au7ez10OcT3l+x/EJTU9KZ
 1VC07UI/mGBqI2c3LCDDhztd3l8Y0jupPTB2jmjQovVXuU7Q/7zEwk4Clv9MVWrBdPjd yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qgyck29k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9WgXp110392
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:29 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qgyck28x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 04:36:29 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9Wji1021355;
        Tue, 10 Nov 2020 09:36:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 34q0840mgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 09:36:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AA9aOvu1114750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 09:36:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEF1D42047;
        Tue, 10 Nov 2020 09:36:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B2A042041;
        Tue, 10 Nov 2020 09:36:24 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.174.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 09:36:24 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/3] s390/vmem: minor cleanup
Date:   Tue, 10 Nov 2020 10:36:20 +0100
Message-Id: <cover.1605000280.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=868 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi David,

Nothing really fancy here, just couple of cleanups

Alexander Gordeev (3):
  s390/vmem: remove redundant check
  s390/vmem: fix possible memory overwrite
  s390/vmem: make variable and function names consistent

 arch/s390/mm/vmem.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.26.0

