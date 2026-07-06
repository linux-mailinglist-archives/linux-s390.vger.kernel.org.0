Return-Path: <linux-s390+bounces-21572-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +aD3JQ89S2pJOAEAu9opvQ
	(envelope-from <linux-s390+bounces-21572-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 07:28:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E627470C9AC
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 07:28:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=NqCvs3pY;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21572-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21572-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A0AC30022A4
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 05:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848613542D4;
	Mon,  6 Jul 2026 05:28:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED5433E86;
	Mon,  6 Jul 2026 05:28:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315724; cv=none; b=Q9p9IB7uuE0QGUzskZM+zFnSd8nzR5O+0TRQcDdOtvin44cTHEn59OKmHz1I1LRXntoCYR5+qSDCN+9bssyB2XCyBGPzRUrm0EjaX5CzeUduTaV4qoib5PFYHSef3R7qcjQXcSMOHxBp+p85KdrJoVZwMIQqblujJlLSP6gYARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315724; c=relaxed/simple;
	bh=Op7YrmDRvG3IQNqVgcMBaMgVoL5djEN1e5l0//V33j4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GzREqL8HhUlDMyAA+uHfzbmRSPCRk8zn9lRG5w+Q4YXedPOfI/BFLSLLXzGtIhsccrOFAhhw+0TulhlVbBLyItVSZxJw5Zsuye7ZgSmGSeKPUGtQVSqGZOoSaJtWuWk64wJmCDQ80L45GwTpVHu9qvE+zAuXTtSlczQy2SB//wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NqCvs3pY; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIDNn2197654;
	Mon, 6 Jul 2026 05:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qyT8QO
	PwSCCU+wrCNesdHnEoidpizVQFXDm2JOPh3Ls=; b=NqCvs3pY15h1C7mpnIjIaN
	6jlCH42vtL2ODLXxmTALUdQExNoGcX68JO94EtwfUAL21T7CaUG/plS81M6YmYMU
	k6FtpqURKyqbAvIOV0ibqzLJhP2o68nJBh7er1hWV/J4dU9y3r7MLI0G54UwszRj
	fzvtb5Ii5fzFCyrJ+m3hrCWGbb7MgT2o8FZ2ODTNu93yFGfhODuQsf7BjXrNRKur
	5zXNA6HnZ2gf0SeENwLApCO7qKJ5TFesQ0PxQ/7sXzUSxj43bz/1g2ujukK9Y8m0
	8i9DFq3s+9sqM3pGje6tZ8wTkDXeDPsLQ82NRJ++2CsXKUSZWGtQu3uqVpmsfjKQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4fqrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 05:27:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6665JdIY031696;
	Mon, 6 Jul 2026 05:27:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h430r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 05:27:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6665RI5U51511744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 05:27:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3CE120043;
	Mon,  6 Jul 2026 05:27:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E0C20040;
	Mon,  6 Jul 2026 05:27:18 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jul 2026 05:27:18 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
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
 <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
In-Reply-To: <69ACC6A7-7845-41B4-B0D0-2E6FCDA7443D@zytor.com>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
	<BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
	<yt9dwlvca8rn.fsf@linux.ibm.com> <87ldbsmnie.ffs@fw13>
	<yt9d5x2w5r84.fsf@linux.ibm.com>
	<20260703105718.GO751831@noisy.programming.kicks-ass.net>
	<akecJWAJP-e5CYP_@kunlun.suse.cz> <yt9dtsqg480p.fsf@linux.ibm.com>
	<69ACC6A7-7845-41B4-B0D0-2E6FCDA7443D@zytor.com>
Date: Mon, 06 Jul 2026 07:27:17 +0200
Message-ID: <yt9dwlv8adsa.fsf@linux.ibm.com>
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
X-Proofpoint-GUID: PVkMc2zyQ0D-fUI5jf8JPax52k-2R9m6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA1MCBTYWx0ZWRfX4qHTNGyBlHze
 ZpjjhVXVNWUf52+eH/j3Xj275yLvQIX9M5+SfrKeFVExBXF3r8VQK7M4tt8Et5rma8xzWEUxOye
 +Dm8prjgMBXEoa/9S0SMzMEpqSbYfMlMqMhsiRtF8j6NbGqjQAlv2ikwCzE1288nR/F43heFGQX
 8+8uMJ4Q/fmxYy0YasNluoqfxvSGTcHc9er9G/Zp/2d6fZEZs7HKrufFkld/iHPCWGL8rdCKPwJ
 K9giRvtbCnCiTL+FmCUbnj0P9Zi7MgRA0tfj2R1TjbFSlKyLgkwvhDY1Pc3M2MRBe7MsbFs7FZ1
 nxBXSQA+y+IAdsPPdmIvbKJfUuBDeIkbubPAVgd/Jnt0CI+mnzetibKeul6Tdue5QowHOnF32J5
 6URwC4eT3UI9Tskf2Szq1xngH6vioDy9MLJ0ahrSeimGXO4WRBwDhrcsVJwI0R9HB6YZGjRoDEA
 lGo2MhmSUrdNq5tTP6g==
X-Proofpoint-ORIG-GUID: DB5Cizx3s3LIu5FN8bbo5Zw1FptATo2x
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b3cbc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=oGMlB6cnAAAA:8
 a=VnNF1IyMAAAA:8 a=MuErSGU5NpPTm9C_53oA:9 a=QEXdDO2ut3YA:10
 a=NdAtdrkLVvyUPsUoGJp4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA1MCBTYWx0ZWRfX+MY8RMEHb64s
 y8kuegBntKLPrluFLndLQY7dg8NCbGkUX7kXz8/Z7uIHXtMeQlR3E2d6vH13gFXOSJAb+B/Rugv
 TNusXlfi/XZQLeaclmqkQoCtkwFx/OM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060050
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21572-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hpa@zytor.com,m:msuchanek@suse.de,m:peterz@infradead.org,m:tglx@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m
 :linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[svens@linux.ibm.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,infradead.org,kernel.org,lwn.net,linuxfoundation.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,suse.de:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E627470C9AC

"H. Peter Anvin" <hpa@zytor.com> writes:

> On July 3, 2026 4:39:18 AM PDT, Sven Schnelle <svens@linux.ibm.com>
> wrote:
>>Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>>
>>> The same could be asked of syscall_enter_from_user_mode. I find it
> very
>>> odd. Why does it conflate the syscall number with its return value?
>>>
>>> It never uses the syscall number passed in except when returning it
>>> unchanged. When it pokes the registers it reads the syscall number
> from
>>> them.
>>>
>>> If the caller of syscall_enter_from_user_mode only read the syscall
>>> number from the registers when syscall_enter_from_user_mode returns
> and
>>> indicates the syscall should be still executed this whole shenigan
> would
>>
>>I agree. The fact that if (nr < NR_syscall) just works because -1
> gets
>>casted to 0xffffffff and is therefore out of bounds is very odd.
>>
>
> Not at all strange. It is an *extremely* common construct in C,
> especially for range checking values into [0, n).

A clear indication that this is not as common as you think is that
there's an extra comment in arch/x86/entry/syscall_64.c:

       /*
	* Convert negative numbers to very high and thus out of range
	* numbers for comparisons.
	*/

If everyone knows what this is the comment wouldn't be necessary. But
that cast is not the thing i'm really interested in - if it stays
that way, fine with me. But I would like to see the change from Michal
going in which untangles the secure_computing() return value from the
syscall number. Because this behaviour is very subtle and removing that
would make things easier. (And also easier to read/audit, which is
always importand with security related code, which seccomp/syscall
clearly is).

> In addition to being idiomatic, keep in mind that this is one of the
> absolutely most performance critical paths in the entire kernel. One
> of the fundamental cornerstones behind Unix is to keep system calls
> cheap so that they can be simple building blocks for more complex
> operations. It is not the only possible design philosophy, but it is
> the one we chose to adopt, quite successfully.
>
> The downside? Squeezing every possible cycle out of the system call
> path becomes one of the most essential tuning tasks. The good part is
> that keeping the system call path clean also makes it maintainable,
> even when there are quirks.

I haven't measured it, but I doubt that the unsigned vs signed syscall
bounds check makes a difference in real world scenarios. Even for
ni_syscall cases it would be small. With the C entry code we have
nowadays such optimizations should be left to the compiler. I wouldn't
be surprised if the generated code is even the same.

But as written above, I don't really care about this.

