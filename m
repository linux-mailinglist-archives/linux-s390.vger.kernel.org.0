Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230481394BE
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jan 2020 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMPYs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 Jan 2020 10:24:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgAMPYs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 10:24:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DFIK2j081616
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 10:24:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xfve9s85d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 10:24:47 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 13 Jan 2020 15:24:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 15:24:43 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DFOf8T37290086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 15:24:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1E042049;
        Mon, 13 Jan 2020 15:24:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A75B4205E;
        Mon, 13 Jan 2020 15:24:41 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.108])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jan 2020 15:24:41 +0000 (GMT)
Date:   Mon, 13 Jan 2020 16:24:39 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
In-Reply-To: <3db7eaf7-6020-365b-c849-9961e483352e@redhat.com>
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
        <20200110184050.191506-5-imbrenda@linux.ibm.com>
        <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
        <20200113133325.417bf657@p-imbrenda>
        <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
        <20200113135832.1c6d3bb8@p-imbrenda>
        <22b5ce6a-18af-edec-efc6-e03450faddf8@redhat.com>
        <20200113150504.3fd218d5@p-imbrenda>
        <3db7eaf7-6020-365b-c849-9961e483352e@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011315-4275-0000-0000-000003972CDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011315-4276-0000-0000-000038AB234B
Message-Id: <20200113162439.7ae81f84@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_04:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=832 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130125
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 13 Jan 2020 15:43:28 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 13.01.20 15:05, Claudio Imbrenda wrote:
> > On Mon, 13 Jan 2020 14:10:10 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> > [...]
> >   
> >> :) I'm confused by the fact that you "expect_pgm_int()" but
> >> actually don't expect one ...
> >>
> >> Please enlighten me why this isn't
> >>
> >> +	sclp_mark_busy();
> >> +	h->length = 8;
> >> +	sclp_setup_int();
> >> +
> >> +	asm volatile(
> >> +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc
> >> %1,%2 */
> >> +		"       ipm     %0\n"
> >> +		"       srl     %0,28"
> >> +		: "=&d" (cc) : "d" (valid_code), "a"
> >> (__pa(pagebuf))
> >> +		: "cc", "memory");
> >> +	if (!cc)
> >> +		sclp_wait_busy();
> >> +	report(cc == 0, "Instruction format ignored bits");
> >>
> >> I feel like I am missing something important.  
> > 
> > because if we take an unexpected pgm interrupt:
> > * the interrupt handler will write stuff on the console using SCLP
> > * it will wait for the busy flag to be cleared before doing so
> > * thus it will hang.
> > 
> > this would be solved by adding special logic to the pgm interrupt
> > handler (as we have discussed in your previous email)
> >   
> 
> I see, so the issue should hold for all SCLP checks where we don't
> expect an exception ... hmmm
 
which is why my wrapper in the unit test is so complicated :)

