Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD231564F6
	for <lists+linux-s390@lfdr.de>; Sat,  8 Feb 2020 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgBHPBy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 8 Feb 2020 10:01:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbgBHPBy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 10:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581174112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=tj3wbtoZ44vGIwM4jmb/APZeawLnv3cGSSGEr1pHaOY=;
        b=OyrVVey/1QUkUni2Rs+p2QjemdthS/qoLg6HKjl4EbTZ2kjRofLRAh2gsoftGtpUPHBIX+
        brNNfFaeBgsKIfSGwm0zlcc9SyedN3ECFpgxjBMHMZmqVN+F4d/0uwDTkZVQp1P/fVE6qA
        KiJmv1wFcA8NBSJsfNsFJxKPh66Tttc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-sKqT_MHHMVmIJDP0eZd_zA-1; Sat, 08 Feb 2020 10:01:48 -0500
X-MC-Unique: sKqT_MHHMVmIJDP0eZd_zA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF96DBA3;
        Sat,  8 Feb 2020 15:01:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55F645D9C9;
        Sat,  8 Feb 2020 15:01:42 +0000 (UTC)
Subject: Re: [PATCH 23/35] KVM: s390: protvirt: STSI handling
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-24-borntraeger@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a4c37bd-2340-9f2f-75d3-792520ed840b@redhat.com>
Date:   Sat, 8 Feb 2020 16:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-24-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Save response to sidad and disable address checking for protected
> guests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

