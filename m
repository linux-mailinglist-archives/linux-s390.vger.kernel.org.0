Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6D1A0C8C
	for <lists+linux-s390@lfdr.de>; Tue,  7 Apr 2020 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgDGLK6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Apr 2020 07:10:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728474AbgDGLK5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:10:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B7bAT047915
        for <linux-s390@vger.kernel.org>; Tue, 7 Apr 2020 07:10:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 308rc4028x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 07:10:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 7 Apr 2020 12:10:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Apr 2020 12:10:26 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 037BAmfi60620846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Apr 2020 11:10:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE219A405B;
        Tue,  7 Apr 2020 11:10:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72C43A4054;
        Tue,  7 Apr 2020 11:10:47 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.8.150])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Apr 2020 11:10:47 +0000 (GMT)
Date:   Tue, 7 Apr 2020 13:00:13 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: s390: vsie: Fix delivery of addressing
 exceptions
In-Reply-To: <20200403153050.20569-3-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
        <20200403153050.20569-3-david@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040711-4275-0000-0000-000003BB444E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040711-4276-0000-0000-000038D0A4AD
Message-Id: <20200407130013.2898fb57@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_03:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070091
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  3 Apr 2020 17:30:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> Whenever we get an -EFAULT, we failed to read in guest 2 physical
> address space. Such addressing exceptions are reported via a program
> intercept to the nested hypervisor.
> 
> We faked the intercept, we have to return to guest 2. Instead, right
> now we would be returning -EFAULT from the intercept handler,
> eventually crashing the VM.
> 
> Addressing exceptions can only happen if the g2->g3 page tables
> reference invalid g2 addresses (say, either a table or the final page
> is not accessible - so something that basically never happens in sane
> environments.
> 
> Identified by manual code inspection.
> 
> Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested
> virtualization") Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 076090f9e666..4f6c22d72072 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) scb_s->iprcc = PGM_ADDRESSING;
>  		scb_s->pgmilc = 4;
>  		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
> +		rc = 1;
>  	}
>  	return rc;
>  }

so, the reason why we never noticed this issue before is simply that
nobody tried running a misbehaving nested guest?

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

