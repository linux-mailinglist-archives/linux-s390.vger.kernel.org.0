Return-Path: <linux-s390+bounces-345-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54934806A96
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F605280D7E
	for <lists+linux-s390@lfdr.de>; Wed,  6 Dec 2023 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63421D535;
	Wed,  6 Dec 2023 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MV5/DkUa"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9033A19AE;
	Wed,  6 Dec 2023 01:02:01 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68m20f018926;
	Wed, 6 Dec 2023 09:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ABnlKyy3xcPzTAvTlIEIOdRTL3YhRZabOC0JsEORLd8=;
 b=MV5/DkUatUooXjyUuW++zLHfO8BOVb4iviffw4yWhRwhXOxkg67a2OO/kFmNTwHS23a8
 oRq81BbaFiPTIzJXfubNExzwqjXCNraoLy/2N6pFgEvGj9oNDMGMtW4Y91gHHhdaYleS
 HgJ6uVL3Vy6Ou77KVBc8LIfWwDM0xpY+y8PKvyium+zjF4gSJVOq10gNOKlIm7lWe6hv
 L8bUQczFvJGhnjnes7UdLpCpoJBjty9VwphKlIfPbTC0O8BkHdUjWRZh85hp7gO2oTnO
 sVPHJSE5I4eGEBR96EI6lZ1pjvWoeRqjrYVtHkdUnVr7NAI62mPw1UHR2GQkk4YHrUwf ow== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utnru0hgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 09:01:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B68eIqv017788;
	Wed, 6 Dec 2023 09:01:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utav2b9xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 09:01:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B691LO413238968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 09:01:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BDAE2004B;
	Wed,  6 Dec 2023 09:01:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7506A20040;
	Wed,  6 Dec 2023 09:01:20 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.9.211])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Dec 2023 09:01:20 +0000 (GMT)
Date: Wed, 6 Dec 2023 10:01:18 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com, hca@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        nsg@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH v1 1/1] s390: mm: convert pgste locking functions to C
Message-ID: <ZXA4XkU0M1BZ5R5k@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7xU8E8UIsYPsx-OAM8UiQ0nq83LgGxBi
X-Proofpoint-GUID: 7xU8E8UIsYPsx-OAM8UiQ0nq83LgGxBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_06,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=346 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060073

On Tue, Dec 05, 2023 at 06:32:52PM +0100, Claudio Imbrenda wrote:

(Internal lists only)

...
> +	do {
> +		value = __atomic64_or_barrier(PGSTE_PCL_BIT, ptr);

Would it make sense to cpu_relax() here, e.g with a follow-up patch?

> +	} while (value & PGSTE_PCL_BIT);
> +	value |= PGSTE_PCL_BIT;
>  #endif
> -	return __pgste(new);
> +	return __pgste(value);
>  }

Thanks!

