Return-Path: <linux-s390+bounces-4932-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A892D854
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jul 2024 20:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9311A1C20E6F
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jul 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040B1953A2;
	Wed, 10 Jul 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D4oh6IIA"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61317194C9A;
	Wed, 10 Jul 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636772; cv=none; b=Yw5KaDb9b9VEmgBubPgxV+/o3TrrCKO2QzyolflUlO2YbQO803tCqUGBh4nmcNyRfier1iArscz7WW6AdcJ1a6skf6sZ067BIS0XPu77KhlRFUb/SXN+rLc1Dd5kx30E0dz5aODjopil+2bnPGosr0D8hr7TfJ57aYd2MM6pdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636772; c=relaxed/simple;
	bh=izlLU66iX1BqXJn7AoTYzA7s3Q7/n/O2q7QEUtsGV7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHgvAIlrq6K1JK3K5G7DduF47TJ7BkWkBPmtOFjW1DSZXsehjOgQuXsp+jtzclvVQIJKsYChxMNs3GZZ20q+Yu4Ina3CBEu67F3BocIKgFWBI1Czi1tLuNrZo6Jhy2st8SRbbcYNSdqLrEuMLqKaa8A9RUxJXZD9ECGDzsSrxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D4oh6IIA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AIRgNw002303;
	Wed, 10 Jul 2024 18:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	bdhuDIEvgIfbkqtTBn515HRfwqJOQtzVzIZW5TuwZ4c=; b=D4oh6IIAvPxwnE3O
	CduEpGPRe91ly19sMNx5Forw9kWBpPFHLQM9DfI9vx7dpyy5Z0G/rSFL0dcWa2p6
	CdUWaffwcJuVSomr+jNufCT4UfvoBcM6rAh0yZwDMy6wpkJpdiBYFqjXioDM7d/u
	Br8zrV4eB09D/ztWBCXmKRaroZMy3mLdf31nC1cS6mvSm6S0+zTFocupFVEnxtoD
	I/Dv8fGVOHQmTvG9JTVGfY+a39zrjStvN/cGrRGAF9djYmrBm5miygGZOk62RU5J
	FmEFxh7SfQObvxRHUh/hsATeJYhyzb+QQh7MVhBx1aJAhx94khj2G7dNs6gKQkWH
	p5SP3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409x9y0757-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 18:39:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46AIdC79020724;
	Wed, 10 Jul 2024 18:39:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409x9y0753-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 18:39:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46AFH09X024670;
	Wed, 10 Jul 2024 18:39:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8ud1gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 18:39:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46AId6Cn33882516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 18:39:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 580F52004D;
	Wed, 10 Jul 2024 18:39:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABBD32004F;
	Wed, 10 Jul 2024 18:39:05 +0000 (GMT)
Received: from darkmoore (unknown [9.179.4.238])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 10 Jul 2024 18:39:05 +0000 (GMT)
Date: Wed, 10 Jul 2024 20:39:03 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v1 2/9] selftests: kvm: s390: Add kvm_s390_sie_block
 definition for userspace tests
Message-ID: <20240710203903.397b9ce6.schlameuss@linux.ibm.com>
In-Reply-To: <20240709174022.348db1a9@p-imbrenda.boeblingen.de.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-3-schlameuss@linux.ibm.com>
	<20240709174022.348db1a9@p-imbrenda.boeblingen.de.ibm.com>
Organization: IBM
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d7w_VOWo1eMIlDl-SOAELgaQzweabHnh
X-Proofpoint-GUID: Xgv5iM7FjMlovi5c82-AHC1RHkPmDhJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_13,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=800
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407100129

On Tue, 9 Jul 2024 17:40:22 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue,  9 Jul 2024 14:56:57 +0200
> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
> 
> > Subsequent tests do require direct manipulation of the SIE instruction.
> > This commit introduces the SIE definition for the selftests.
> > 
> > There are already definitions of this within the kernel.
> > This differs in two ways.
> > * This is the first definition of this in userspace.
> > * This does not require atomicity for the flags.  
> 
> you say this here,
> 
> [...]
> 
> > +#define PROG_BLOCK_SIE	BIT(0)
> > +#define PROG_REQUEST	BIT(1)
> > +	atomic_t prog20;		/* 0x0020 */  
> 
> but then you define this as atomic.
> 
> Is this a mistake, or is there a good reason?
> 
> [...]

Yes, this was an oversight. Will correct that to __u32 in the next version.

Christoph

