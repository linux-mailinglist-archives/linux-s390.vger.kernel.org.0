Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5EB104A
	for <lists+linux-s390@lfdr.de>; Thu, 12 Sep 2019 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfILNsA (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Sep 2019 09:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbfILNsA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 09:48:00 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D102881DF2
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 13:47:59 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id h6so17072wmb.2
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 06:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xzNw99jxEnIn2C2qOEKRvRaD87jmfzIh56BZ8T38JHI=;
        b=KH9HXNgL02T4K3malNR7rjcBFHTYTPgwz+T3uE6jSDpms7p0LBfQyPCmAAiBi8UA+C
         52h+vDJ5Drz6GRmF9/fNDbTHMPMlOkEYKw1UJ4AI6afwpmdQg0P7zrLdp0IHBmfPDYJ8
         6G7SyS08PjN1QrIYqREMrZrfwawPYsRu6a9kEH5Hk1fsQyrIK9M9Od7rWymi4xSMYXNv
         1sfuBAYjirXKvW+FAdabyDrXaYpnqwsOI0FJeM+ejZ4PehKOpvoi2CgeQ+fgdexbDwj4
         OLKPn2X6FB69WRcP5u3xUugl6Zr7ux2W+xMUaBRMBA2mPUj1k7Y4Cgcy/BOb3tWQ4/uy
         X0FQ==
X-Gm-Message-State: APjAAAX/foMLAUHMzQw7bO88M8sRxtChqXdogvI8GxR/yD9cHCeFlMnl
        c16mGkB3QzLILr26Jop4jQc+mYZsdFrYF/cJN6oGoGAR86zJPvraOEq5URpIqow00y9Q6QsmRQb
        U1g20FogYxqqE3L063yzVDw==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr21687152wrx.247.1568296078541;
        Thu, 12 Sep 2019 06:47:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+M/n5hIxegDbetVZMCKqPkNBW+2nAMB37M5VeK+GsMI2smzcMhJ052+Vim4txa6aJX6q9kQ==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr21687130wrx.247.1568296078214;
        Thu, 12 Sep 2019 06:47:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3166:d768:e1a7:aab8? ([2001:b07:6468:f312:3166:d768:e1a7:aab8])
        by smtp.gmail.com with ESMTPSA id q19sm34965289wra.89.2019.09.12.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:47:57 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: s390: Fixes for 5.3
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
References: <20190912133921.6886-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5801e7ea-84f6-011f-82fb-167302d95814@redhat.com>
Date:   Thu, 12 Sep 2019 15:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912133921.6886-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/09/19 15:39, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.3-1

Pulled, thanks.

Paolo
