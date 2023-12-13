Return-Path: <linux-s390+bounces-331-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC08805E10
	for <lists+linux-s390@lfdr.de>; Tue,  5 Dec 2023 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA3D1C20B3E
	for <lists+linux-s390@lfdr.de>; Tue,  5 Dec 2023 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52463DFD;
	Tue,  5 Dec 2023 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZP++RQKO"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6408CD41;
	Tue,  5 Dec 2023 10:49:22 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5IjYYL016762;
	Tue, 5 Dec 2023 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=iDfqMsGgHo6OPb8fjdSSMrZs5hCYCoC6wwlPMgirfs8=;
 b=ZP++RQKOvnjYIOzDi4YafAJmH1o2eW+iIVpHjznMrHA3svvUZQ3eW4ghwRZxW50q83EM
 i7rsixrh0fAYsJsa8nxh9TjmEkN8FL8ssY+oKAruB8yyl2AeH+HQ0jsitlqU4Z2evHgM
 5egpbpR55ZFMYgaI4mdq4PPfgAC572WKnHLZ4t48uDALcLUa9H6bqB5EuplNXpQtvcEX
 uOA2r6/xE2tzepPaWRJ+HJ7IndtkHfy7JDKEEMEtYzCtDWR786hN7LEHAGspr/EClHiK
 xz1yG/WqkqfKN7Ofb24yMPlBeYCWJevcwqveO0sggPJcRLsSLQW2/7FdKDlnm1SSC9XU /Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut9dwr3p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 18:49:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5GjLip022637;
	Tue, 5 Dec 2023 18:49:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urhm283h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 18:49:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5InD4E23855626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Dec 2023 18:49:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E300E2004B;
	Tue,  5 Dec 2023 18:49:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6ED20040;
	Tue,  5 Dec 2023 18:49:13 +0000 (GMT)
Received: from osiris (unknown [9.179.8.210])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Dec 2023 18:49:13 +0000 (GMT)
Date: Tue, 5 Dec 2023 19:49:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Message-ID: <20231205184911.5381-A-hca@linux.ibm.com>
References: <20231205173252.62305-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205173252.62305-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iPEPHnYiVzznPu8EI935PF8pJYs_6i2R
X-Proofpoint-GUID: iPEPHnYiVzznPu8EI935PF8pJYs_6i2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=550
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050148

On Tue, Dec 05, 2023 at 06:32:52PM +0100, Claudio Imbrenda wrote:
> Convert pgste_get_lock() and pgste_set_unlock() to C.
> 
> There is no real reasons to keep them in assembler. Having them in C
> makes them more readable and maintainable, and better instructions are
> used automatically when available.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/mm/pgtable.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

