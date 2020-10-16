Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29A82906DB
	for <lists+linux-s390@lfdr.de>; Fri, 16 Oct 2020 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408615AbgJPOLh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 16 Oct 2020 10:11:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408627AbgJPOLf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Oct 2020 10:11:35 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GE43G5076648;
        Fri, 16 Oct 2020 10:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=sEnYWY8yE4jQWIi16q//lDCj9zLF0A98vGTigeRbEYs=;
 b=M7ZGbe7LY+bhDqo9QEeapHzQYGPL3dcLeRcokiH3CENmNgHg1jTZvSK/fuULlHtZQS78
 nJdr/wIhzwpEVoWWIbHpawlteGK+DtKpWb3u515ZJoAsvxfK4k0OukWLaudAZV+8eURs
 SQFoPSqpOYBJTjrA3KsuaZY8NQtTmkcbCjctWmOYnIc5jxdRX/bs1GRNtETdbpoF6eq8
 f4wlMHu+nDCXE2k25A4zMNAcuZz9gcaKXgPCuBv8sKwbgqc7Vb4G2Goh6WsAYPgdcVf7
 6hB/Z/Q2xEVniRzpPTXFD82K9qN1bafMrypluW+P8Hnxb6/t68Q7X7xFBqnystSh03ry RQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 347cwngd1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 10:11:32 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09GE7ltF021587;
        Fri, 16 Oct 2020 14:11:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 344558tp05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 14:11:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09GEBRfF7405994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 14:11:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D78834C059;
        Fri, 16 Oct 2020 14:11:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADD204C04A;
        Fri, 16 Oct 2020 14:11:26 +0000 (GMT)
Received: from ibm (unknown [9.145.37.78])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Oct 2020 14:11:26 +0000 (GMT)
Date:   Fri, 16 Oct 2020 16:11:25 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Petr Tesarik <ptesarik@suse.cz>
Cc:     linux-s390@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: Is OS_INFO_VMCOREINFO unimplemented?
Message-ID: <20201016161125.2fcf494d@ibm>
In-Reply-To: <20201013145303.6f99fe89@ezekiel.suse.cz>
References: <20201013145303.6f99fe89@ezekiel.suse.cz>
Organization: IBM
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_07:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=591 clxscore=1011 lowpriorityscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Petr,

sorry for the late reply.

It's an interface for non-Linux systems for the stand-alone kdump.

But that's all I'm sure of. I'm afraid only Michael knows the full history
behind the implementation. Unfortunately he left IBM ~2 years ago so this piece
of knowledge is lost...

My theory is that originally it was planned to use this mechanism for the
"normal" kdump as well. But for kdump common code "corrupts" the vmcoreinfo by
adding the CRASHTIME shortly before kexec'ing the crash kernel. So the crash
kernel would refuse to load the os_info anyway and thus it is never set.

Hope this helps you at least a little
Philipp


On Tue, 13 Oct 2020 14:53:03 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> Hi all,
> 
> I've been looking into kernel crash dump analysis for some time now,
> and I've noticed that none of my sample dumps for z/Architecture sets
> OS_INFO_VMCOREINFO.
> 
> Commit 4857d4bbe9821c8d732cb84455e18e12b3d79add suggests that the
> "os_info" structure should contain vmcoreinfo, but it seems that the
> corresponding fields are always zero, and a quick grep for
> OS_INFO_VMCOREINFO finds only code that tries to read this entry in the
> panic kernel, but no code that would initialize it in the old (crashed)
> kernel.
> 
> In short, the panic kernel always prints an informational message that
> entry 0 is not available and falls back to get_vmcoreinfo_old().
> 
> Is this a bug, or is this interface used by a non-Linux operating
> system that I'm not aware of?
> 
> TIA,
> Petr Tesarik
> SUSE HW Enablement
