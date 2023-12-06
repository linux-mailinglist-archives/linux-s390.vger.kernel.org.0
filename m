Return-Path: <linux-s390+bounces-347-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD428070B1
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 14:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95B01C209BA
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353D37155;
	Wed,  6 Dec 2023 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M7EZlmmL"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C599AC;
	Wed,  6 Dec 2023 05:14:32 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6DCqZ4025505;
	Wed, 6 Dec 2023 13:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=J8hfys2B2Zx7SCxn/IF3Kr91+Z9EXpfrC00nX/GDFi0=;
 b=M7EZlmmLnleKmsbrS+mZ0tVtXno0vNcS/kHQZFK5eFclDcge18/lvhqauOTFdmQO1edR
 zUSGNlYiruP48E9dO9QYeI4Q81PA59KUTYZGHZVq4Ccgi9wEjCG9pGy3VKC5C7C5Ptyw
 xMC/b96Yewpks9D4F+r4dCki6k7o2agSiCwtK5PitCYDdI7MF2f03XLmz0CvYh7bHp+y
 ptR4t+B0yiRvi5EQPgLfKV1bPtz6eeJJpclvgbdEkaenczlhXS8q1tjkDlb8blemOL9a
 iL90/VR/xvzNXqRZ6qqexfq+eLMxKCZvZZJvrY2vcdCdbhvk9yZFLMIX4pFB4aek4um4 Xg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utsn203dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 13:14:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6D4AAF009905;
	Wed, 6 Dec 2023 13:14:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utavjmg2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 13:14:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6DEQ8S3605208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 13:14:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58CC420043;
	Wed,  6 Dec 2023 13:14:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23E2D20040;
	Wed,  6 Dec 2023 13:14:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Dec 2023 13:14:26 +0000 (GMT)
Date: Wed, 6 Dec 2023 14:14:24 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Message-ID: <ZXBzsCT5vaufHGIZ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231205173252.62305-1-imbrenda@linux.ibm.com>
 <ZXA4XkU0M1BZ5R5k@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20231206091541.6897-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206091541.6897-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4SUixVMoQyN4a9y8KrDc1-wqkq3l4j3_
X-Proofpoint-GUID: 4SUixVMoQyN4a9y8KrDc1-wqkq3l4j3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_10,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxlogscore=397 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060108

On Wed, Dec 06, 2023 at 10:15:41AM +0100, Heiko Carstens wrote:
> On Wed, Dec 06, 2023 at 10:01:18AM +0100, Alexander Gordeev wrote:
> > On Tue, Dec 05, 2023 at 06:32:52PM +0100, Claudio Imbrenda wrote:
> > ...
> > > +	do {
> > > +		value = __atomic64_or_barrier(PGSTE_PCL_BIT, ptr);
> > 
> > Would it make sense to cpu_relax() here, e.g with a follow-up patch?
> 
> No, because cpu_relax() is a no-op on our architecture (besides that it
> translates to barrier(); but __atomic64_or_barrier() obviously comes also
> with barrier() semantics).
> 
> We used to do diag 0x44 with cpu_relax() but that caused many performance
> problems, therefore we removed diag 0x44 completely from the kernel quite
> some time ago.
> 
> See also commit 1b68ac8678a8 ("s390: remove last diag 0x44 caller").

Thanks for the clarification!

Applied.

