Return-Path: <linux-s390+bounces-21496-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4YPLKpVVRmooRAsAu9opvQ
	(envelope-from <linux-s390+bounces-21496-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 14:12:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1881B6F760F
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 14:12:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=ml+WJYct;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21496-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21496-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 219E63086820
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10A47D92C;
	Thu,  2 Jul 2026 12:02:46 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B747ECC6;
	Thu,  2 Jul 2026 12:02:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993766; cv=none; b=YimzP2Z0j/WeOipLH+Lm3GmX/8UqMMfS0OLlH1eN86r8vu92s8pBhS3Gvh3vrCDCi8KcxSG498HOE5rvFZWrOLwpPXdmMwJCGJ1SlP5luZvMv4aunPFvnR50K6zmHsPWuJKTDTykXyCSDE/QRc5NwnFegU1LSQdxqFCtGcWMRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993766; c=relaxed/simple;
	bh=QXmH97+rWFoE2LAC88xt78ijllYCri9Xy6EsF1mVG6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WZa9/y2alHrmBQV+86eN+efOsfSL1A0ygj6yxs+7v9ClHeo4W+T6dcy+qHRyhsodtqLYxMAiDCkYEqTs1WYR7rTMdYLZ8b1onz5pc1wuN7oSLAH0EkR+42sSV/Z9lSuJoj2okftEbsMfbAllFUNP/kFYWIGa495hY3zEcbMP9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ml+WJYct; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621L37U2348150;
	Thu, 2 Jul 2026 12:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QXmH97
	+rWFoE2LAC88xt78ijllYCri9Xy6EsF1mVG6c=; b=ml+WJYctAzI5wdjjSDMgvP
	yYV2w0V14fb3FrleDRxXeZt2X9/C22lawvIy7y0+0JO66Vi6gKw1lfHi9eAyE3iB
	yoS3fYqtxvDpQ43tfL4lGRPA5bWXjXIUzVbxyYQxDdyfE1K1xqrHplG4o7Hdt20S
	AAsRGGTujytG5lXsdMbtKS8RLTE8pa6avsUyvnDduHvV2z5CY707mxKR2JNyI+r7
	IyOEJGe3WbV44naL8/o58lDH/tLH40lAil+soXDKPbWG+Z9RTVSTWMSdqkH2nDOb
	QLgPM5fv80o4n+0Z6dHnxoe02Eo3+yY6DnjNa6v6ZGL9BhLroq2Z252BbEu2DIUQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk1c1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 12:01:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662BnaEX019880;
	Thu, 2 Jul 2026 12:01:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhkrrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 12:01:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662C13ZQ50987300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 12:01:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4769020049;
	Thu,  2 Jul 2026 12:01:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF39620040;
	Thu,  2 Jul 2026 12:01:02 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Jul 2026 12:01:02 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet
 <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun
 Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akYreY_BHuRbxSsO@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <yt9dechlbyj0.fsf@linux.ibm.com>
	<akYreY_BHuRbxSsO@kunlun.suse.cz>
Date: Thu, 02 Jul 2026 14:01:02 +0200
Message-ID: <yt9d5x2xbny9.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX/Q+2VIkEZeXm
 zSpy3sSNQGU/T2UgslNS6VsPuREql8uSSdJVoQTob97qLRSMv8GJjVr6kKiJKJCJeXAZoKLkJvq
 5f+8ytV2grsx0grvISHbwQ84vmEGrrdzVPGn9ShEzfJJHyfO1sPZ67aE51b4LMU/UA4XKMH4nm3
 i3aZUnP9MOw4vJ1Gv1srPH7aTjCuWOOkR4qKRHoTc08VZ+RLjIvr8Wq1ycDRZScggqf8vwMr62U
 JjJTrtJxIQEPkt6pbRVU3+sX0S+j9wkj8f1eX7QLV6sX7z6Zs+pNzCEJDl3mKhspgytP+uB/ism
 Cbiu9d27//atMwvdZ67Jmyysa6pe9elrVf0h5Ag/2OdiGgMqcKBh7JR9tfXjSJ286bhQpmHm/WG
 VZ+c5pOODZgvCHxA60BGuyRiMofbgW+8J+7uiJsQ4y6cR6g7q0HtmmyhZwGSkt8korNuifin5NM
 AFNwBLKljHK92fKlxUQ==
X-Proofpoint-GUID: 4HRNE-F5FeM-i_rZBbEwAtB_lah-fAD7
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a465304 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=96I0iGyHsLkaCD_aHbUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX3fqq5rJK1Pw6
 XAlVAtz6S5ae1lDAR5UGIg8LAyH/oHFacO80fJr93TGA5Wz3SkDELaofBJAuvm8s6hTRnqUcZGM
 jGAhDbq6yYnrtndAHrmEOWgPfMLlxrw=
X-Proofpoint-ORIG-GUID: COL-UTUh6U9SgZkk02MSCnjQmBsVFo93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21496-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:msuchanek@suse.de,m:peterz@infradead.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m
 :linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[svens@linux.ibm.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[svens@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1881B6F760F

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Thu, Jul 02, 2026 at 10:12:35AM +0200, Sven Schnelle wrote:
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>>=20
>> > The return value of syscall_enter_from_user_mode is used both for the
>> > adjusted syscall number and the indicator that a syscall should be
>> > skipped.
>> >
>> > As seccomp can be invoked on any syscall, including invalid ones this
>> > somewhat undermines seccomp.
>> >
>> > While the seccomp variants that terminate the process do not need to
>> > care about this for the filter that sets the syscall return value this
>> > disctinction is required.
>> >
>> > Pass the syscall number as a pointer to the inline entry functions, and
>> > use the return value exclusively for the indication that the syscall is
>> > already handled.
>> >
>> > This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is t=
he
>> > workaround for exactly this deficiency.
>>=20
>> I'm not sure whether PIF_SYSCALL_RET_SET can be removed - the syscall
>> return might still get set by PTRACE_SET_SYSCALL_INFO when the tracee is
>> stopped. This might be a positive number which can't be distinguished
>> from a syscall number. But maybe i'm missing something? It's been quite
>> a while since I touched all that ptrace stuff.
>
> When the syscall return value is set (in the registers) the return value
> which is also the modified syscall number is set to -1 indicating the
> syscall was handled. At least that's how the API is described.
>
> So yes, if the syscall number range is restricted or the syscall number
> is returned through a path different from the function return value the
> flag should not be needed in the entry path because the case can be
> detected through the return value alone.

I'm still failing to see how this would work without an additional
flag. Assume a program (the tracee) is stopped because of a syscall
entry. The tracer then decides to skip the syscall and changes
regs->gpr2 (which contains either the syscall number or return value)
to contain 42. When the tracer than restarts the syscall, how does
do_syscall() know that gpr2 is now a return value and not a syscall number?

