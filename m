Return-Path: <linux-s390+bounces-344-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B97806A81
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 10:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20F21C203B0
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468C19BBA;
	Wed,  6 Dec 2023 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c5NZ5UIK"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF42E61B9;
	Wed,  6 Dec 2023 00:58:34 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68vTIO009799;
	Wed, 6 Dec 2023 08:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ISl0fS/mpcUn+lUjikzWC/7sO4gOEikKQhJO+IQpDsk=;
 b=c5NZ5UIKp1bbmkZHIo/6Xqj6zIVD2g1mLpxPZKZp0SGvOojBGvjv/3Yo4eHTr0qfJkND
 NafG1UwSfdOKmPw2u5W5YLLJXCAK2S4jOOi6eq9v5yBOeoalIw4KfqTFTc4xgLDFGi9K
 Hv5x0EmCAJIe7PN23XehL1mmBu/idm83I2qU8JetHkDAyjOGjA/3YSEkfNl7h56zIyiC
 md7whW3856pBTHkvFiaTMBaPy61sKKKlaDlHu1EGCtaiDO55jQvqxKhKqKvVBTeXh74Q
 NMb9PTEstfWP8XGJqaNGqEMNFWNgLcnfkCxGBsQCDWmxg90to9XN+TLCKBYk8zClbDVI lQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utnw5r0kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 08:58:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68e5wE031492;
	Wed, 6 Dec 2023 08:58:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkb8y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 08:58:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B68wRL727656848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 08:58:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3896D20043;
	Wed,  6 Dec 2023 08:58:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17EE12004B;
	Wed,  6 Dec 2023 08:58:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.9.211])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Dec 2023 08:58:25 +0000 (GMT)
Date: Wed, 6 Dec 2023 09:58:24 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com, hca@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        nsg@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Message-ID: <ZXA3sLyiyngQ14Vx@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Mail-Followup-To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux390-list@tuxmaker.boeblingen.de.ibm.com,
	kvm390-list@tuxmaker.boeblingen.de.ibm.com, hca@linux.ibm.com,
	borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
	nsg@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
	gerald.schaefer@linux.ibm.com
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
X-Proofpoint-GUID: opjzfeIZgDDfba-aJZ-8HHGaG0fFJyks
X-Proofpoint-ORIG-GUID: opjzfeIZgDDfba-aJZ-8HHGaG0fFJyks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_06,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=534
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060072

On Tue, Dec 05, 2023 at 06:32:52PM +0100, Claudio Imbrenda wrote:

Hi Claudio,

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

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

