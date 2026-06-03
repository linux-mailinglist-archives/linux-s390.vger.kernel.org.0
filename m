Return-Path: <linux-s390+bounces-20434-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 58EvB+UHIGqKuQAAu9opvQ
	(envelope-from <linux-s390+bounces-20434-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 12:54:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17161636BF2
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 12:54:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Z1Ddarc7;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20434-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20434-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0D2830374A3
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE773CB2FC;
	Wed,  3 Jun 2026 10:51:15 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5037C930;
	Wed,  3 Jun 2026 10:51:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483875; cv=none; b=j4M0zQCD0td6U2k1dlmxuD08OabVuxc5hPJLRo/edr8rNJEwde7YQQljaRdewl3fzW/Cm+sXkvpPUYz9hHJyRsMy2PJoIdZSPvNrBFRUECN70bpSeUm8NkFJ2QqkwxWRfMUZcu8zRwl1kB01xYtit66KkMY1Xfi/aigAbeHLa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483875; c=relaxed/simple;
	bh=6ZKXTiMW/7YSjd7kkGDPpxt5UT/yWF92f/xb/1kbuhg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IceBPf6UpxA3fYTzR/tS7vW/bXofs8qo4kf9K2dAHE33XEBMVETPNhNxtigFCDupwnwfbHrKQGa7u8ag0F1cNLk3Gu2W6R8shnQDz60NKISlsz6hWZrJPdO/kpOcBLSIBHuGd3Wmr4rCIhLKt22w3sPmqWBuGwBlm/6/BtKzBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z1Ddarc7; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65357F1u3707959;
	Wed, 3 Jun 2026 10:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LOJsOP
	wkIwlgCS18JAElKjEnxKYIPK0zcfATi/KUj6o=; b=Z1Ddarc7rco7vl/PxJ4bu/
	zasNJIpG5Zzs9CTteCdeE91sVzpJ41No+Q5v92uher7OYoakJXgI3/i64AYjIArn
	ldrPgB03/ouPVeHdh99vf0u1i+cY2NZqwMCEz22wnMO4ei5GrwERqJjlk8bE+zA7
	na6TG4SShVQgAwDhVAYJlmgjhdKzK44Vn3+EMBAIPCIEoD/LuL6ZawATzOKyVwLe
	bMFs4+ZU5cXnjLXxP0elMZ7kVuk4jU1Yhqif+Gix4NVSdggRJG3GKUPu5/hzNl1/
	6UHRycuxH26qGl+6OpFKyYZbOAa+BPU8AY6WR3315GMPIN6r/KBLXv0iZi+xWtdQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaea07v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 10:51:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653AdRxJ018831;
	Wed, 3 Jun 2026 10:51:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyffhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 10:51:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653Ap9V036700714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 10:51:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6414158054;
	Wed,  3 Jun 2026 10:51:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0A475805F;
	Wed,  3 Jun 2026 10:51:06 +0000 (GMT)
Received: from [9.111.88.117] (unknown [9.111.88.117])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 10:51:06 +0000 (GMT)
Message-ID: <e79d242ecee2090993538498c6169a999ef96e97.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] s390/pci: Preserve FMB state in device
 re-enablement
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        alex@shazbot.org
In-Reply-To: <20260519224204.19154-2-oelghoul@linux.ibm.com>
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
	 <20260519224204.19154-2-oelghoul@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 12:50:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a20071f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=I0uwnR3MyKlnoB6GPqIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GbrluoWtwfonReyU43F7fR8TEDvV6sVB
X-Proofpoint-ORIG-GUID: GbrluoWtwfonReyU43F7fR8TEDvV6sVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwMiBTYWx0ZWRfX6S+hR5jz+Y6j
 dFJQuxGQ1Iunw2Z/6TJzsuCTQMueuAacaNDTmffaqVImoD13UOh/9GSd98+dqZr9oFqUkWC5+DU
 MamK1QuvE60VewvZOZo0Fllziaz1suSZF4IcUk70UgPs6iNPVT/ArB81N0riqIbCkFozdbonR2p
 O5faHLzDoOGbte3dC/xm8eNtR5FkRUa+aPGoAQEleVFFIFfPfj6yy085DYhLRCgugq8qMnrZvVk
 RJpfG1i+HmUotp1FhHff7dGpSOywWbaNBg2xjtvx5g9lTbQ8Fg2H2bDw8Wern0VTOhDdQLie1al
 u1EoAZuFdyR0MvJCpXOpUpP8/XypFqjn8Ea9NF3LgaAYX1PpBio7plB1gTGPF5JrpteVO6Ict3S
 UrQPLW56MLi7fh6sMd+/49Z+HAt5jKm4kMjDoyLaiUAGv/PPv+a/qlagW/U2Y/fbhuLxHbDVq6P
 0MHWPqaqnUFSmVGjOXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20434-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:oelghoul@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:mjrosato@linux.ibm.com,m:alifm@linux.ibm.com,m:farman@linux.ibm.com,m:gbayer@linux.ibm.com,m:alex@shazbot.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fib.gd:url,linux.ibm.com:from_mime,linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[schnelle@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17161636BF2

On Tue, 2026-05-19 at 18:42 -0400, Omar Elghoul wrote:
> Introduce a function zpci_fmb_reenable_device() that checks for the state
> of the FMB and reuses the same buffer where appropriate. If FMB was not
                                                             ^ the

> previously enabled, it enables it for the device. Call this function duri=
ng
> a zPCI device re-enablement, which in turn implicitly ensures that the FM=
B
> is enabled for host devices during their KVM registration.
>=20
> This function also clears out the software counters, so that a program
> resetting an FMB would see all its counters restart from zero as expected=
.
> The function to clear the software counters is also separated into a stat=
ic
> function as it is now reused in both zpci_fmb_enable_device() and
> zpci_fmb_reenable_device().

While the commit message starts in the correct imperative voice it then
drifts to a passive voice in the last sentence. "is also separated
into=E2=80=A6", "it is now reused".

Better:
"Besides re-enabling the FMB itself in zpci_fmb_reenable_device() also
clear out the software counters, such that a program resetting an FMB
sees all counters start from zero as expected. Separate this clearing
of software counters out into zpci_fmb_clear_iommu_ctrs() and reuse it
in zpci_fmb_enable_device() and zpci_fmb_reenable_device()."

>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  1 +
>  arch/s390/pci/pci.c         | 75 +++++++++++++++++++++++++++++--------
>  2 files changed, 61 insertions(+), 15 deletions(-)
>=20
--- snip ---
> +}
> +
> +/* Modify PCI: Set PCI function measurement parameters */
> +int zpci_fmb_enable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +
> +	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +		return -EINVAL;
> +
> +	zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> +	if (!zdev->fmb)
> +		return -ENOMEM;
> +	WARN_ON((u64) zdev->fmb & 0xf);
> =20
> +	zpci_fmb_clear_iommu_ctrs(zdev);
> =20
>  	fib.fmb_addr =3D virt_to_phys(zdev->fmb);

I think there is still some potential for sharing the actual enable
code between zpci_fmb_enable_device() and zpci_fmb_reenable_device()
e.g. using a static zpci_fmb_do_enable(struct zpci_dev *zdev) helper.
I think that still makes it clearer what's happening too.

>  	fib.gd =3D zdev->gisa;
> @@ -227,6 +232,41 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
>  	}
>  	return cc ? -EIO : 0;
>  }
> +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
> +
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);

Sashiko correctly notes a pre-existing issue in that
zpci_fmb_enable_device() is called without holding zdev->fmb_lock in
pcibios_enable_device() and analogously zpci_fmb_disable_device() in
pcibios_disable_device(). This should also be caught by lockdep if we
had lockdep_assert_held() was in zpci_fmb_enable_device() respectively
zpci_fmb_disable_device(). Would you mind adding a minimal fix patch
for this pre-existing issue in your series? The fix should add the
locking in the pcibios calls as well as add lockdep_assert_held(). Also
don't forget a Fixes tag and Cc stable.

> +
> +	if (!zdev->fmb)
> +		return zpci_fmb_enable_device(zdev);
> +
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measurement=
 */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc =3D=3D 3 is not a valid stat=
e here
> +	 * because we are re-enabling function measurement for the same functio=
n
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zpci_fmb_clear_iommu_ctrs(zdev);
> +
> +	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Re-enable function measureme=
nt */
> +	if (cc) {
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> =20

The change itself makes sense to me.

Thanks,
Niklas

